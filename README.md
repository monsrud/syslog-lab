# Syslog-NG Remote Log Server for Lab/Home Use #

Run syslog-ng in a docker container. Allows servers to log remotely to this central log server. Log files are saved to 
/var/lib/docker/volumes/syslog-ng-lab. 

Run:  sh ./build.sh

Configure your servers to log remotely to this service via the parent/host's IP address, port 5514 (so as not to conflict
with the parent host's syslog on port 514).

