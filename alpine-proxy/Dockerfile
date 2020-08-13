FROM alpine
RUN apk update && apk upgrade && apk add curl nginx
ADD rootfs.tar.gz /
HEALTHCHECK CMD curl localhost
ENTRYPOINT ["nginx", "-g", "daemon off;"]
