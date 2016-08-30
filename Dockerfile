#From Aliyun instead of offical image, because we are in china (GFW)
FROM registry.aliyuncs.com/acs-sample/centos:7
#FROM centos:7
MAINTAINER Fer Uria <fauria@gmail.com>
LABEL Description="Linux + Apache 2.4 + PHP 5.4. CentOS 7 based. Includes .htaccess support and popular PHP5 features, including mail() function." \
	License="Apache License 2.0" \
	Usage="docker run -d -p [HOST PORT NUMBER]:80 -v [HOST WWW DOCUMENT ROOT]:/var/www/html fauria/lap" \
	Version="1.0"

ARG user=jenkins
ARG group=jenkins
ARG uid=1002
ARG gid=1002

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container, 
# ensure you use the same uid
RUN groupadd -g ${gid} ${group} \
    && useradd -u ${uid} -g ${gid} -m -s /bin/bash ${user}
    
RUN yum -y update && yum clean all
RUN yum -y install epel-release && yum clean all

## Add new repo
## RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

RUN yum clean all
RUN yum install -y httpd postfix 
RUN yum install -y vim mariadb 

# Install php
RUN yum install -y \
	php55w \
	php55w-common \
	php55w-cli \
	php55w-gd \
	php55w-intl \
	php55w-ldap \
	php55w-mbstring \
	php55w-mysqlnd \
	php55w-pdo \
	php55w-soap \
	php55w-mcrypt \
	php55w-ldap \
	php55w-xml \
	php55w-xmlrpc \
	php55w-opcache \
	php55w-pecl-memcache \
	php55w-pecl-igbinary

ENV LOG_STDOUT **Boolean**
ENV LOG_STDERR **Boolean**
ENV LOG_LEVEL warn
ENV ALLOW_OVERRIDE All
ENV DATE_TIMEZONE UTC

COPY index.php /var/www/html/
COPY run-lap.sh /usr/sbin/
RUN chmod +x /usr/sbin/run-lap.sh
RUN chown -R ${user}:${group} /var/www/html

VOLUME /var/www/html
VOLUME /var/log/httpd

EXPOSE 80

CMD ["/usr/sbin/run-lap.sh"]
