#!/bin/bash
sudo docker build -t wpclisql:latest . 


# loop for as many domains as we have setup
# array=( example.com myotherdomain.com somenewwebsite.com )

readarray domains < domains.txt

for DOMAIN in "${domains[@]}"
do
  echo $DOMAIN
  docker-compose down -v
  docker-compose up -d


  docker exec -it wpup_wordpress_1 /bin/sh -c ' while ! wp --allow-root db check --silent; do printf "."; sleep 1; done'


  docker exec -it wpup_wordpress_1 wp --allow-root core install --path="/var/www/html" --url="http://$DOMAIN" --title="Local Wordpress By Docker" --admin_user=root  --admin_email=foo@baljlkjljlkjr.com --skip-email
  docker exec -it wpup_wordpress_1 wp --allow-root user update 1 --user_pass=banana

  # TODO: loop here or at the top level?

  #docker exec -it wpup_wordpress_1 wp --allow-root option update home "http://example.com" 
  #docker exec -it wpup_wordpress_1 wp --allow-root option update siteurl "http://example.com"

  #docker exec -it wpup_wordpress_1 wp --allow-root plugin install --activate static-html-output-plugin --version=5.5.1

  #docker exec -it wpup_wordpress_1 wp --allow-root plugin install --activate static-html-output-plugin
  docker exec -it wpup_wordpress_1 mv /tmp/static-html-output-plugin/ /var/www/html/wp-content/plugins/
  docker exec -it wpup_wordpress_1 wp --allow-root plugin activate static-html-output-plugin

  docker exec -it wpup_wordpress_1 wp --allow-root plugin update static-html-output-plugin --dry-run

done

echo 'all looped out'


