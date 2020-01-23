FROM alpine
RUN apk update
RUN apk upgrade
RUN apk add curl nginx
ADD rootfs.tar.gz /
HEALTHCHECK CMD curl localhost
ENTRYPOINT ["nginx", "-g", "daemon off;"]
