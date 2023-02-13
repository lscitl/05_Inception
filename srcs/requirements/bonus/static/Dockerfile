# syntax=docker/dockerfile:1

FROM alpine:3.17.2

ARG CONFIG_PATH=/etc/nginx/http.d/default.conf

RUN apk add --update --no-cache py3-pip nginx && \
	pip install mkdocs && \
	mkdocs new webserv

COPY ./conf/default.conf $CONFIG_PATH
COPY ./conf/webserv.md /webserv/docs/index.md
COPY ./conf/mkdocs.yaml /webserv/mkdocs.yaml

RUN mkdocs build -f /webserv/mkdocs.yaml

EXPOSE 8000

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
