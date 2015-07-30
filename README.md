# fauria/lap

![docker_logo](https://googledrive.com/host/0B7q6BLMXak9VfkpQY3YzNldlSmtxRTZCMEtEVlhhR3QtMFc3aEYzVzA5YlM5MWw5OXhqV0U/docker_139x115.png)![docker_fauria_logo](https://googledrive.com/host/0B7q6BLMXak9VfkpQY3YzNldlSmtxRTZCMEtEVlhhR3QtMFc3aEYzVzA5YlM5MWw5OXhqV0U/docker_fauria_161x115.png)

This Docker container implements a LAP stack, as well as some popular PHP modules and a Postfix service to allow sending emails through PHP [mail()](http://php.net/manual/en/function.mail.php) function.

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
	* php-pgsql
	* php-pspell
	* php-recode
	* php-snmp
	* php-soap
	* php-xml
	* php-xmlrpc

### Installation from [Docker registry hub](https://registry.hub.docker.com/u/fauria/lap/).

You can download the image using the following command:

```bash
docker pull fauria/lap
```
<!--
### Volumes and variables

This image makes use of some environment variables to allow the configuration of some parameteres at run time.

This is [on GitHub](https://github.com/jbt/markdown-editor) so let me know if I've b0rked it somewhere.


Props to Mr. Doob and his [code editor](http://mrdoob.com/projects/code-editor/), from which
the inspiration to this, and some handy implementation hints, came.

The root directory for the website files is /.../

The container exposes port 80.

You can customize this settings at run time, as describes in the following:

3. Use cases

a. Running a temporary container for testing purposes.

docker ...

b. Running a container for production, with xxx

docker ...

TODO
-->
