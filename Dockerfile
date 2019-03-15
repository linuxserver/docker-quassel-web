FROM lsiobase/alpine:3.8

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	git && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	npm && \
 echo "**** install quassel webserver ****" && \
 git clone https://github.com/magne4000/quassel-webserver /app/qwebserver && \
 cd /app/qwebserver && \
 npm install && \
 echo "**** cleanup ****" && \
 cp /app/qwebserver/settings.js /defaults && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root && \
 mkdir -p \
	/root

# add local files
COPY root/ /

# ports and volumes
EXPOSE 64080 64443
