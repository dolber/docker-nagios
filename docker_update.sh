#!/bin/sh

NOW="$(date +%F_%H.%M.%S)"

docker pull jasonrivers/nagios
docker build -t nagios4:alex .

docker update --restart=no nagios4
docker stop nagios4
docker rename nagios4 nagios4_$NOW

docker run --name nagios4 -d -h de.our-dns.info \
        --restart=always \
        -v /opt/nagios/etc:/opt/nagios/etc \
        -v /opt/nagios/var:/opt/nagios/var \
        -v /opt/nagios/plugins:/opt/Custom-Nagios-Plugins \
        -v /opt/nagios/nagiosgraph/var:/opt/nagiosgraph/var \
        -v /opt/nagios/nagiosgraph/etc:/opt/nagiosgraph/etc \
        -e MAIL_INET_PROTOCOLS="all" -e NAGIOS_FQDN="de.our-dns.info" -e NAGIOS_TIMEZONE="Europe/Kiev" \
        -p 0.0.0.0:8881:80 nagios4:alex
#   -p 0.0.0.0:8881:80 jasonrivers/nagios:latest

# in docker
# apt-get install python3-requests python3-session

