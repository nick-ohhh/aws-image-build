#!/bin/bash
#install dependencies, start nginx
sudo apt-get -y update
sudo apt-get -y install curl
sudo apt-get -y install wget

#managed by puppet now
# sudo apt-get -y install nginx
# sudo ufw allow 'Nginx HTTP'
# sudo service nginx start

sudo apt -y install awscli
sudo apt-get -y install puppet-agent
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
wget https://raw.githubusercontent.com/nokeefe/aws-image-build/master/puppet/instance_setup.pp
sudp /opt/puppetlabs/bin/puppet apply image_setup.pp

#add bucket logo to nginx homepage
cd /var/www/html/
sudo aws s3 cp s3://jjbalogo/jjba_logo.jpg .
sudo sed -i '14 a <img src="jjba_logo.jpg" alt="JoJos Bizarre Adventure logo">' index.nginx-debian.html

#change default nginx config to return 301 and redirect elsewhere
cd /etc/nginx/site-available/
sudo sed -i '49 a location /jjba {\n\treturn 301 https://www.youtube.com/watch?v=dQw4w9WgXcQ' default

#change default log location
sudo mkdir /var/log/nick
cd /etc/nginx/
sudo sed -i 's|\<access_log /var/log/nginx/access.log;\>|access_log /var/log/nick/access.log;|g' nginx.conf