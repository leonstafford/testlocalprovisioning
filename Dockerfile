FROM wordpress:latest


RUN apt-get update \
&& apt-get install -y mysql-server iputils-ping wget unzip

# install wp cli
RUN curl -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

RUN cd /tmp && wget https://downloads.wordpress.org/plugin/static-html-output-plugin.5.6.zip && unzip static-html-output-plugin.5.6.zip 
