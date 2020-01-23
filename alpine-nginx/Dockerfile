FROM alpine
RUN apk update
RUN apk upgrade
RUN apk add curl nginx
COPY overlay/ /
HEALTHCHECK CMD curl localhost
ENTRYPOINT ["nginx", "-g", "daemon off;"]
