#!/bin/bash

function exportBoolean {
    if [ "${!1}" = "**Boolean**" ]; then
            export ${1}=''
    else
            export ${1}='Yes.'
    fi
}

exportBoolean LOG_STDOUT
exportBoolean LOG_STDERR

if [ $LOG_STDERR ]; then
    /usr/bin/ln -sf /dev/stderr /var/log/httpd/error_log
else
	LOG_STDERR='No.'
fi

if [ $ALLOW_OVERRIDE == 'All' ]; then
    /usr/bin/sed -i 's/AllowOverride\ None/AllowOverride\ All/g' /etc/httpd/conf/httpd.conf
fi

if [ $LOG_LEVEL != 'warn' ]; then
    /usr/bin/sed -i "s/LogLevel\ warn/LogLevel\ ${LOG_LEVEL}/g" /etc/httpd/conf/httpd.conf
fi

# stdout server info:
if [ ! $LOG_STDOUT ]; then
cat << EOB

    **********************************************
    *                                            *
    *    Docker image: fauria/lap                *
    *    https://github.com/fauria/docker-lap    *
    *                                            *
    **********************************************

    SERVER SETTINGS
    ---------------
    · Redirect Apache access_log to STDOUT [LOG_STDOUT]: No.
    · Redirect Apache error_log to STDERR [LOG_STDERR]: $LOG_STDERR
    · Log Level [LOG_LEVEL]: $LOG_LEVEL
    · Allow override [ALLOW_OVERRIDE]: $ALLOW_OVERRIDE
    · PHP date timezone [DATE_TIMEZONE]: $DATE_TIMEZONE

EOB
else
    /usr/bin/ln -sf /dev/stdout /var/log/httpd/access_log
fi

# Set PHP timezone
/usr/bin/sed -i "s/\;date\.timezone\ \=/date\.timezone\ \=\ ${DATE_TIMEZONE}/" /etc/php.ini

# Run Postfix
2>/dev/null /usr/sbin/postfix stop
/usr/sbin/postfix start

# Run Apache:
2>/dev/null /usr/sbin/apachectl -k stop
if [ $LOG_LEVEL == 'debug' ]; then
    /usr/sbin/apachectl -DFOREGROUND -k start -e debug
else
    &>/dev/null /usr/sbin/apachectl -DFOREGROUND -k start
fi

