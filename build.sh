#!/bin/sh
set -e

CONTAINER_NAME=syslog-lab
IMAGENAME=syslog-lab
CONTAINER_FE=docker  # or CONTAINER_FE=podman

$CONTAINER_FE container stop ${CONTAINER_NAME} > /dev/null 2>&1 || true
$CONTAINER_FE container rm ${CONTAINER_NAME} true > /dev/null 2>&1 || true

# minimal syslog-ng config

cat << EOF > syslog-ng.conf 

@version: 3.22

options {
    keep_hostname (yes);
    chain_hostnames (yes);
};

source syslog_udp { udp(ip("0.0.0.0") port(514)); };

destination d_remote_logs { file( "/var/log/\${HOST}.log"); };

log {  source(syslog_udp); destination(d_remote_logs); };

EOF

$CONTAINER_FE build -t $IMAGENAME --rm=true --force-rm=true --no-cache .
echo ""
echo "Start your container with the command:"
echo ""
echo "$CONTAINER_FE run --name ${CONTAINER_NAME} -d -v ${CONTAINER_NAME}:/var/log -p 5514:514/udp ${IMAGENAME}"

rm syslog-ng.conf

