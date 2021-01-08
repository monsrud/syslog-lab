FROM alpine:3.12

RUN apk add --no-cache syslog-ng

ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf

EXPOSE 514/udp

CMD ["/usr/sbin/syslog-ng","--foreground","--cfgfile","/etc/syslog-ng/syslog-ng.conf"]
