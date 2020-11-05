# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tkomatsu <tkomatsu@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/05 13:33:42 by tkomatsu          #+#    #+#              #
#    Updated: 2020/11/05 20:57:45 by tkomatsu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
FROM debian:buster

ENV ENTRYKIT_VERSION 0.4.0

#install tools
RUN	apt-get update && apt-get install -y \
		mariadb-client \
		mariadb-server \
		nginx \
		openssl \
		php-bcmath \
		php-cgi \
		php-common \
		php-fpm \
		php-gd \
		php-gettext \
		php-mbstring \
		php-mysql \
		php-net-socket \
		php-pear \
		php-xml-util \
		php-zip \
		unzip \
		vim \
		wget

# install phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz \
	&& tar xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz \
	&& mv phpMyAdmin-4.9.0.1-all-languages/ /var/www/html/phpmyadmin \
	&& rm phpMyAdmin-4.9.0.1-all-languages.tar.gz

# install entrykit
RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink

WORKDIR	/

COPY srcs /tmp/

#install wordpress
RUN	wget https://wordpress.org/latest.tar.gz \
	&& tar -xvzf latest.tar.gz \
	&& rm latest.tar.gz \
	&& mv wordpress /var/www/html/ \
	&& cp /tmp/wp-config.php /var/www/html/wordpress/ \
	&& chown -R www-data:www-data /var/www/html/wordpress

# configure a wordpress database
RUN bash /tmp/mysql.sh

# configure nginx for wordpress
RUN	cp /tmp/default.tmpl /etc/nginx/sites-available/

# configure phpmyadmin
RUN cp /tmp/config.inc.php /var/www/html/phpmyadmin/

# configure ssl
RUN mkdir /etc/nginx/ssl \
	&& openssl genrsa -out /etc/nginx/ssl/localhost.key 2048 \
	&& openssl req -new -x509 -days 3650 -key /etc/nginx/ssl/localhost.key -out /etc/nginx/ssl/localhost.crt -subj "/C=JP"

EXPOSE 80 443

#CMD bash /tmp/service_start.sh
ENTRYPOINT ["render", "/etc/nginx/sites-available/default", "--", "bash", "/tmp/service_start.sh"]
