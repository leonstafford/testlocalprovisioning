#!/bin/bash

docker-compose down -v


sudo docker build -t wpclisql:latest . 

docker-compose up -d



docker exec -it wpup_wordpress_1 curl -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp 
docker exec -it wpup_wordpress_1 chmod +x /usr/local/bin/wp 

#sleep 10

docker exec -it wpup_wordpress_1 /bin/sh -c ' while ! wp --allow-root db check --silent; do printf "."; sleep 1; done'


docker exec -it wpup_wordpress_1 wp --allow-root core install --path="/var/www/html" --url="http://example.com" --title="Local Wordpress By Docker" --admin_user=root  --admin_email=foo@baljlkjljlkjr.com --skip-email
docker exec -it wpup_wordpress_1 wp --allow-root user update 1 --user_pass=banana
#docker exec -it wpup_wordpress_1 wp --allow-root option update home "http://example.com" 
#docker exec -it wpup_wordpress_1 wp --allow-root option update siteurl "http://example.com"
#docker exec -it wpup_wordpress_1 wp --allow-root plugin install --activate static-html-output-plugin
docker exec -it wpup_wordpress_1 wp --allow-root plugin install --activate static-html-output-plugin --version=5.5.1
docker exec -it wpup_wordpress_1 wp --allow-root plugin update static-html-output-plugin --dry-run
