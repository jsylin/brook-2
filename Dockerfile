FROM alpine:latest
LABEL name=brook
#RUN brook_new_ver=`wget -qO- https://github.com/txthinking/brook/tags| grep "/txthinking/brook/releases/tag/"| head -n 1| awk -F "/tag/" '{print $2}'| sed 's/\">//'` && \
ARG VERSION=v20190401
RUN apk add -U iproute2 tzdata curl && ln -s /usr/lib/tc /lib/tc \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN  wget --no-check-certificate -O /usr/sbin/brook "https://github.com/txthinking/brook/releases/download/${VERSION}/brook" \
   && chmod +x /usr/sbin/brook

ENV execfile	/usr/sbin/httpd
ENV serverport 61089
ENV password	pwd
ENV OPTIONS	""
ENV LIMIT_CONN 500
ENV RATE 500mbit


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

