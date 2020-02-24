FROM debian:buster-slim

ENV STEAMCMDDIR="/home/steam/steamcmd" \
	STEAMAPPNAME="" \
	STEAMAPPID=0 \
	STEAMAPPDIR="/home/steam/game-dedicated"

COPY *.sh /usr/local/bin/

RUN set -x \
	&& chmod 755 /usr/local/bin/*.sh \
	&& sed -i 's@/deb.debian.org/@/mirrors.aliyun.com/@g;s@/security.debian.org/@/mirrors.aliyun.com/@g' /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		lib32stdc++6 \
		lib32z1 \
		g++-multilib \
		gdb \
		wget \
		rsync \
		ca-certificates \
	&& useradd -u 1000 -m steam \
	&& su steam -c "initsteamcmd.sh" \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR $STEAMAPPDIR

VOLUME $STEAMAPPDIR
