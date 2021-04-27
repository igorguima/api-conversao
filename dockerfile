FROM node:14-alpine

ARG CONFIG_PATH=./.docker

WORKDIR /app

COPY . /app
COPY ${CONFIG_PATH}/nginx.conf /etc/nginx/nginx.conf
COPY ${CONFIG_PATH}/proxy.conf /etc/nginx/conf.d/default.conf
COPY ${CONFIG_PATH}/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ${CONFIG_PATH}/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN \
  npm install && \
  apk add --no-cache --update curl nginx tzdata supervisor && \
  echo "America/Sao_Paulo" > /etc/timezone && \
  cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime 

HEALTHCHECK \
  CMD curl --fail http://127.0.0.1/status || exit 1

EXPOSE 80

CMD ["/usr/local/bin/docker-entrypoint.sh"]