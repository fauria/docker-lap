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
exportBoolean DISALLOW_OVERRIDE

if [ $LOG_STDERR ]; then
    /usr/bin/ln -sf /dev/stderr /var/log/httpd/error_log
else
	LOG_STDERR='No.'
fi

if [ ! $DISALLOW_OVERRIDE ]; then
    /usr/bin/sed -i 's/AllowOverride\ None/AllowOverride\ All/g' /etc/httpd/conf/httpd.conf
    DISALLOW_OVERRIDE='No.'
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
    · Redirect Apache access_log to STDOUT: No.
    · Redirect Apache error_log to STDERR: $LOG_STDERR
    · Disallow override: $DISALLOW_OVERRIDE
    · PHP date timezone: $DATE_TIMEZONE

EOB
else
    /usr/bin/ln -sf /dev/stdout /var/log/httpd/access_log
fi

# Set PHP timezone
/usr/bin/sed -i "s/\;date\.timezone\ \=/date\.timezone\ \=\ ${DATE_TIMEZONE}/" /etc/php.ini

# Run Postfix
/usr/sbin/postfix start

# Run Apache:
/usr/sbin/apachectl -DFOREGROUND -k start -e debug
