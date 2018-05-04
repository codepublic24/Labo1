#!/bin/bash -xe

# [Description:]
#   Setup Redmine.
#  [Usage]
#    sudo passwd root
#    
#    su root
#    REDMINE_DL_URL=<url>
#    cd /tmp
#    wget https://github.com/codepublic24/Labo1/blob/master/redmine/setup01-redmine.sh
#    chmod +x /tmp/setup01-redmine.sh
#    sed -i".org.1" -e "s/#sudo wget https:\/\/<url>/sudo wget https:\/\/${REDMINE_DL_URL}/g" /tmp/setup01-redmine.sh
#    /tmp/setup01-redmine.sh

mkdir /tmp
cd /tmp
pwd

###change time zone
date
sudo timedatectl set-timezone Asia/Tokyo
date

###update
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y wget
sudo apt install -y curl

###config japanese
sudo apt install -y language-pack-ja
echo $LANG
sudo locale-gen ja_JP.UTF-8
sudo update-locale LANG=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
echo $LANG

###install python
sudo apt install -y python3-pip python3-dev
sudo apt install -y python-pip python-dev
python --version
sudo ln -nfs /usr/bin/python3 /usr/bin/python
python --version
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install --upgrade pip
sudo python -m pip list

###install aws-cli
sudo pip install awscli

###install zip scm dependency(ruby,passenger) postgresql apache ImageMagick,JapaneseFont
sudo apt install -y zip unzip
sudo apt install -y subversion git
sudo apt install -y build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev libcurl4-openssl-dev libffi-dev
sudo apt install -y postgresql postgresql-server-dev-9.5
sudo apt install -y apache2 apache2-dev libapr1-dev libaprutil1-dev
sudo apt install -y imagemagick libmagick++-dev fonts-takao-pgothic

####install ruby
cd /tmp
curl -O https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz
tar xvf /tmpruby-2.4.1.tar.gz -C /tmp
cd /tmpruby-2.4.1
./configure --disable-install-doc
make
make install
ruby -v

####install bundle
sudo gem install bundler --no-rdoc --no-ri

####setup postgreSQL
#yes postgres | sudo -u postgres createuser -P redmine
sudo -u postgres psql << EOF
DROP USER redmine;
CREATE USER redmine WITH PASSWORD 'postgres';
SELECT * from pg_user;
\q
EOF
sudo -u postgres createdb -E UTF-8 -l ja_JP.UTF-8 -O redmine -T template0 redmine

####install redmine
cd /tmp
curl -O http://www.redmine.org/releases/redmine-3.4.5.tar.gz
sudo tar xvf /tmpredmine-3.4.5.tar.gz -C /var/lib/
sudo mv /var/lib/redmine-3.4.5 /var/lib/redmine
sudo chown -R www-data:www-data /var/lib/redmine

####setup redmine database
sudo -u www-data cat << EOF > /var/lib/redmine/config/database.yml
production:
  adapter: postgresql
  database: redmine
  host: localhost
  username: redmine
  password: "postgres"
  encoding: utf8
EOF
cat /var/lib/redmine/config/database.yml

####setup redmine config
sudo -u www-data cat << EOF > /var/lib/redmine/config/configuration.yml
production:
  email_delivery:
    delivery_method: :smtp
    smtp_settings:
      address: "localhost"
      port: 25
  rmagick_font_path: /usr/share/fonts/truetype/takao-gothic/TakaoPGothic.ttf
EOF
cat /var/lib/redmine/config/configuration.yml

####setup redmine init
cd /var/lib/redmine
sudo -u www-data bundle install --without development test --path vendor/bundle
sudo -u www-data bundle exec rake generate_secret_token
sudo -u www-data RAILS_ENV=production bundle exec rake db:migrate
sudo -u www-data RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine:load_default_data

####install passenger
sudo gem install passenger -v 5.1.12 --no-rdoc --no-ri
sudo passenger-install-apache2-module --auto --languages ruby

####setup apache
sudo cat << EOF > /etc/apache2/conf-available/redmine.conf
# Allow Redmine image,css,etc
# Access Deny All File as Apache 2.4
<Directory "/var/lib/redmine/public">
  Require all granted
</Directory>
# Passenger config
# https://www.phusionpassenger.com/library/config/apache/reference/
PassengerMaxPoolSize 20
PassengerMaxInstancesPerApp 4
PassengerPoolIdleTime 864000
PassengerStatThrottleRate 10
# Output passenger-install-apache2-module --snippet
EOF
sudo cat /etc/apache2/conf-available/redmine.conf
sudo passenger-install-apache2-module --snippet >> /etc/apache2/conf-available/redmine.conf
sudo cat /etc/apache2/conf-available/redmine.conf
sudo a2enconf redmine
sudo apache2ctl configtest

####setup apache uri
sudo cat << EOF >> /etc/apache2/apache2.conf
#for redmine settings
Alias /redmine /var/lib/redmine/public
<Location /redmine>
  PassengerBaseURI /redmine
  PassengerAppRoot /var/lib/redmine
</Location>
EOF
cat /etc/apache2/apache2.conf

####setup apache boot
apache2ctl configtest
sudo service apache2 reload

####setup apache index
echo "" > /var/www/html/index.html 

#####install redmine plugin
#####https://qiita.com/y_hokkey/items/7c02a3af319b353136d5
#####http://ngyuki.hatenablog.com/entry/2016/04/27/225856
#####http://redmine-media.jp/plugin/recommendation_plugin/opensource_plugin/
#####https://www.r-labs.org/projects/r-labs/wiki/Redmine%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E9%9B%86
cd /tmp
#####https://github.com/onozaty/redmine-view-customize
sudo wget https://github.com/onozaty/redmine-view-customize/archive/v1.1.4.tar.gz -O /tmp/redmine_view_customize-v1.1.4.tar.gz
sudo tar xvf /tmp/redmine_view_customize-v1.1.4.tar.gz -C /var/lib/redmine/plugins/
sudo mv /var/lib/redmine/plugins/redmine-view-customize-1.1.4/ /var/lib/redmine/plugins/view_customize/
#####https://github.com/peclik/clipboard_image_paste
sudo wget https://github.com/peclik/clipboard_image_paste/archive/v1.12.tar.gz -O /tmp/redmine_clipboard_image_paste-v1.12.tar.gz
sudo tar xvf /tmp/redmine_clipboard_image_paste-v1.12.tar.gz -C /var/lib/redmine/plugins/
sudo mv /var/lib/redmine/plugins/clipboard_image_paste-1.12/ /var/lib/redmine/plugins/clipboard_image_paste/
#####https://github.com/GEROMAX/redmine_subtask_list_accordion/\
#sudo wget https://github.com/GEROMAX/redmine_subtask_list_accordion/archive/2.1.0.tar.gz -O /tmp/redmine_subtask_list_accordion-2.1.0.tar.gz
#sudo tar xvf /tmp/redmine_subtask_list_accordion-2.1.0.tar.gz -C /var/lib/redmine/plugins/
#sudo mv /var/lib/redmine/plugins/redmine_subtask_list_accordion-2.1.0/ /var/lib/redmine/plugins/redmine_subtask_list_accordion/
#####https://github.com/hidakatsuya/redmine_default_custom_query
sudo wget https://github.com/hidakatsuya/redmine_default_custom_query/archive/1.3.0.tar.gz -O /tmp/redmine_default_custom_query-1.3.0.tar.gz
sudo tar xvf /tmp/redmine_default_custom_query-1.3.0.tar.gz -C /var/lib/redmine/plugins/
sudo mv /var/lib/redmine/plugins/redmine_default_custom_query-1.3.0/ /var/lib/redmine/plugins/redmine_default_custom_query/
#####https://github.com/danmunn/redmine_dmsf
#sudo wget https://github.com/danmunn/redmine_dmsf/archive/v1.6.1.tar.gz -O /tmp/redmine_dmsf-v1.6.1.tar.gz
#sudo tar xvf /tmp/redmine_dmsf-v1.6.1.tar.gz -C /var/lib/redmine/plugins/
#sudo mv /var/lib/redmine/plugins/redmine_dmsf-1.6.1/ /var/lib/redmine/plugins/redmine_dmsf/
#####https://github.com/akiko-pusu/redmine_issue_templates
sudo wget https://github.com/akiko-pusu/redmine_issue_templates/archive/0.1.9.tar.gz -O /tmp/redmine_issue_templates-0.1.9.tar.gz
sudo tar xvf /tmp/redmine_issue_templates-0.1.9.tar.gz -C /var/lib/redmine/plugins/
sudo mv /var/lib/redmine/plugins/redmine_issue_templates-0.1.9/ /var/lib/redmine/plugins/redmine_issue_templates/
#####https://github.com/alexbevi/redmine_knowledgebase
sudo wget https://github.com/alexbevi/redmine_knowledgebase/archive/v3.2.1.tar.gz -O /tmp/redmine_knowledgebase-v3.2.1.tar.gz
sudo tar xvf /tmp/redmine_knowledgebase-v3.2.1.tar.gz -C /var/lib/redmine/plugins/
sudo mv /var/lib/redmine/plugins/redmine_knowledgebase-3.2.1/ /var/lib/redmine/plugins/redmine_knowledgebase/
#####https://github.com/backlogs/redmine_backlogs
#wget https://github.com/backlogs/redmine_backlogs/archive/v1.0.6.tar.gz -O /tmp/redmine_backlogs-v1.0.6.tar.gz
#tar xvf /tmp/redmine_backlogs-v1.0.6.tar.gz -C /var/lib/redmine/plugins/
#mv /var/lib/redmine/plugins/redmine_backlogs-1.0.6/ /var/lib/redmine/plugins/redmine_backlogs/
#####https://github.com/haru/redmine_code_review/
sudo wget https://github.com/haru/redmine_code_review/archive/0.9.0.tar.gz -O /tmp/redmine_code_review-0.9.0.tar.gz
sudo tar xvf /tmp/redmine_code_review-0.9.0.tar.gz -C /var/lib/redmine/plugins/
sudo mv /var/lib/redmine/plugins/redmine_code_review-0.9.0/ /var/lib/redmine/plugins/redmine_code_review/
#####https://github.com/nutso/redmine-plugin-recurring-tasks
#sudo wget https://github.com/nutso/redmine-plugin-recurring-tasks/archive/v1.6.0.tar.gz -O /tmp/redmine-plugin-recurring-tasks-v1.6.0.tar.gz
#sudo tar xvf /tmp/redmine-plugin-recurring-tasks-v1.6.0.tar.gz -C /var/lib/redmine/plugins/
#sudo mv /var/lib/redmine/plugins/redmine-plugin-recurring-tasks-1.6.0/ /var/lib/redmine/plugins/redmine-plugin-recurring-tasks/
#####https://github.com/two-pack/redmine_xlsx_format_issue_exporter
sudo wget https://github.com/two-pack/redmine_xlsx_format_issue_exporter/archive/0.1.5.tar.gz -O /tmp/redmine_xlsx_format_issue_exporter-0.1.5.tar.gz
sudo tar xvf /tmp/redmine_xlsx_format_issue_exporter-0.1.5.tar.gz -C /var/lib/redmine/plugins/
sudo mv /var/lib/redmine/plugins/redmine_xlsx_format_issue_exporter-0.1.5/ /var/lib/redmine/plugins/redmine_xlsx_format_issue_exporter/
#####https://github.com/haru/redmine_wiki_extensions
sudo wget https://github.com/haru/redmine_wiki_extensions/archive/0.8.1.tar.gz -O /tmp/redmine_wiki_extensions-0.8.1.tar.gz
sudo tar xvf /tmp/redmine_wiki_extensions-0.8.1.tar.gz -C /var/lib/redmine/plugins/
sudo mv /var/lib/redmine/plugins/redmine_wiki_extensions-0.8.1/ /var/lib/redmine/plugins/redmine_wiki_extensions/
#####https://github.com/akiko-pusu/redmine_banner
sudo wget https://github.com/akiko-pusu/redmine_banner/archive/0.1.2.tar.gz -O /tmp/redmine_banner-0.1.2.tar.gz
sudo tar xvf /tmp/redmine_banner-0.1.2.tar.gz -C /var/lib/redmine/plugins/
sudo mv /var/lib/redmine/plugins/redmine_banner-0.1.2/ /var/lib/redmine/plugins/redmine_banner/
#####https://github.com/tkusukawa/redmine_work_time
sudo wget https://github.com/tkusukawa/redmine_work_time/archive/0.3.4.tar.gz -O /tmp/redmine_work_time-0.3.4.tar.gz
sudo tar xvf /tmp/redmine_work_time-0.3.4.tar.gz -C /var/lib/redmine/plugins/
sudo mv /var/lib/redmine/plugins/redmine_work_time-0.3.4/ /var/lib/redmine/plugins/redmine_work_time/

#####Edit Url Agile Plugin
#sudo wget https://<url>/redmine_agile-1_4_6-light.zip -O /tmp/redmine_agile-1_4_6-light.zip
#sudo unzip /tmp/redmine_agile-1_4_6-light.zip  -d /var/lib/redmine/plugins/
#####Edit Url Theme
#sudo wget https://<url>/circle_theme-2_1_3.zip -O /tmp/circle_theme-2_1_3.zip
#sudo unzip /tmp/circle_theme-2_1_3.zip -d /var/lib/redmine/public/themes/

#####change url to jpsite
cd /var/lib/redmine/plugins
sed -i".org.1" -e "s/https:\/\/www\.redmine\.org\/guide/http:\/\/guide\.redmine\.jp\//g" /var/lib/redmine/lib/redmine/info.rb
sed -i".org.2" -e "s/https:\/\/www\.redmine\.org\//http:\/\/redmine\.jp\//g" /var/lib/redmine/lib/redmine/info.rb

####setup apache pulugin
cd /var/lib/redmine/plugins
sudo chown -R www-data:www-data /var/lib/redmine/plugins
sudo bundle install
sudo -u www-data bundle exec rake redmine:plugins:migrate RAILS_ENV=production
sudo service apache2 reload

#Redmine Initial Setting
#https://www.slideshare.net/g_maeda/redmine-52193785

exit 0
