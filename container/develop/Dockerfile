FROM ubuntu:20.04

RUN apt-get update \
 && apt-get install -y \
    build-essential \
    curl \
    git \
    mysql-client \
 && apt-get clean

WORKDIR /usr/local
RUN curl -L https://golang.org/dl/go1.15.5.linux-amd64.tar.gz | tar xvz

ENV PATH=/root/go/bin:/usr/local/go/bin:$PATH

COPY ./container/develop/install_go_tool.sh ./tools/tools.go ./go.mod /usr/local/lib/go-tools/
WORKDIR /usr/local/lib/go-tools
RUN chmod +x ./install_go_tool.sh
RUN ./install_go_tool.sh && rm -rf /root/go/pkg

WORKDIR /usr/local/bin
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.13.0/migrate.linux-amd64.tar.gz | tar xvz \
 && mv migrate.linux-amd64 migrate

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root
ARG ARCH="amd64"
ARG DOCKER_CHANNEL="stable"
ARG DOCKER_VERSION="latest"
ARG DOCKER_COMPOSE_VERSION="1.27.4"
COPY ./container/develop/install_docker.sh /root/
RUN chmod +x ./install_docker.sh
RUN ./install_docker.sh

WORKDIR /root/app
