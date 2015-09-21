FROM docker.xlands-inc.com/baoyu/debian
MAINTAINER djluo <dj.luo@baoyugame.com>

RUN export http_proxy="http://172.17.42.1:8080/" \
    && export DEBIAN_FRONTEND=noninteractive     \
    && apt-get update \
    && apt-get install -y openssh-client supervisor \
    && apt-get clean    \
    && unset http_proxy \
    && unset DEBIAN_FRONTEND   \
    && rm -rf usr/share/locale \
    && rm -rf usr/share/man    \
    && rm -rf usr/share/doc    \
    && rm -rf usr/share/info   \
    && find var/lib/apt -type f -exec rm -fv {} \;

COPY ./entrypoint.pl      /entrypoint.pl
COPY ./supervisord.conf   /supervisord.conf
COPY ./conf               /example/

ENTRYPOINT ["/entrypoint.pl"]
CMD        ["/usr/bin/ssh"]
