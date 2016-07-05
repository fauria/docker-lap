fauria/lap
==========

![docker_logo](https://googledrive.com/host/0B7q6BLMXak9VfkpQY3YzNldlSmtxRTZCMEtEVlhhR3QtMFc3aEYzVzA5YlM5MWw5OXhqV0U/docker_139x115.png)![docker_fauria_logo](https://googledrive.com/host/0B7q6BLMXak9VfkpQY3YzNldlSmtxRTZCMEtEVlhhR3QtMFc3aEYzVzA5YlM5MWw5OXhqV0U/docker_fauria_161x115.png)

This Docker container implements a LAP stack, as well as some popular PHP modules and a Postfix service to allow sending emails through PHP [mail()](http://php.net/manual/en/function.mail.php) function.

If you are looking for a modern, developer friendly container for your latest app, maybe [fauria/lamp](https://hub.docker.com/r/fauria/lamp) suits your needs better.

Includes the following components:

 * Centos 7 base image.
 * Apache HTTP Server 2.4
 * Postfix 2.10
 * PHP 5.4
 * PHP modules
 	* php-common
	* php-dba
	* php-gd
	* php-intl
	* php-ldap
	* php-mbstring
	* php-mysqlnd
	* php-odbc
	* php-pdo
	* php-pecl-memcache
	* php-pecl-zendopcache
	* php-mcrypt
	* php-pgsql
	* php-pspell
	* php-recode
	* php-snmp
	* php-soap
	* php-xml
	* php-xmlrpc

Installation from [Docker registry hub](https://registry.hub.docker.com/u/fauria/lap/).
----

You can download the image using the following command:

```bash
docker pull fauria/lap
```

Environment variables
----

This image uses environment variables to allow the configuration of some parameteres at run time:

* Variable name: LOG_STDOUT
* Default value: Empty string.
* Accepted values: Any string to enable, empty string or not defined to disable.
* Description: Output Apache access log through STDOUT, so that it can be accessed through the [container logs](https://docs.docker.com/reference/commandline/logs/).

----

* Variable name: LOG_STDERR
* Default value: Empty string.
* Accepted values: Any string to enable, empty string or not defined to disable.
* Description: Output Apache error log through STDERR, so that it can be accessed through the [container logs](https://docs.docker.com/reference/commandline/logs/).

----

* Variable name: LOG_LEVEL
* Default value: warn
* Accepted values: debug, info, notice, warn, error, crit, alert, emerg
* Description: Value for Apache's [LogLevel directive](http://httpd.apache.org/docs/2.4/en/mod/core.html#loglevel).

----

* Variable name: ALLOW_OVERRIDE
* Default value: All
* All, None
* Accepted values: Value for Apache's [AllowOverride directive](http://httpd.apache.org/docs/2.4/en/mod/core.html#allowoverride).
* Description: Used to enable (`All`) or disable (`None`) the usage of an `.htaccess` file.

----

* Variable name: DATE_TIMEZONE
* Default value: UTC
* Accepted values: Any of PHP's [supported timezones](http://php.net/manual/en/timezones.php)
* Description: Set php.ini default date.timezone directive.

Exposed port and volumnes
----

The image exposes port `80` and exports two volumes: `/var/log/httpd`, which contains Apache's logs, and `/var/www/html`, used as Apache's [DocumentRoot directory](http://httpd.apache.org/docs/2.4/en/mod/core.html#documentroot). 

The user and group owner id for this directory are both 48 (`uid=48(apache) gid=48(apache) groups=48(apache)`).

Use cases
----

1. Create a temporary container for testing purposes:
 
```
	docker run --rm fauria/lap
```

2. Create a temporary container to debug a web app:
 
```
	docker run --rm -p 8080:80 -e LOG_STDOUT=true -e LOG_STDERR=true -e LOG_LEVEL=debug -v /my/data/directory:/var/www/html fauria/lap
```

3. Create a container linking to another [MySQL container](https://registry.hub.docker.com/_/mysql/):

```
	docker run -d --link my-mysql-container:mysql -p 8080:80 -v /my/data/directory:/var/www/html -v /my/logs/directory:/var/log/httpd --name my-lap-container fauria/lap
```

4. Run

example for my website:

```
docker run -v /data/www/drupal001/:/var/www/html \ 
           -v /data/web_files/drupal001/files:/data/web_files/drupal001/files \
           -v /opt/log/httpd:/var/log/httpd \
           -p 60081:80 --rm --name=dp01 xa/lap
```
