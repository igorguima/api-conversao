#!/bin/ash

exec supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
