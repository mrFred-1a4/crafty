FROM ubuntu:20.04

ENV DEBIAN_FRONTEND="noninteractive"

LABEL maintainer="Phillip Tarrant <https://gitlab.com/Ptarrant1>  Dockerfile created by kevdagoat <https://gitlab.com/kevdagoat> and brought to Unraid by Freddy0 <https://hub.docker.com/u/freddy0>" \
    Name="Crafty-Controller" \
    Version="3.3"

COPY requirements.txt /crafty_web/requirements.txt
RUN apt-get update && apt-get install -y \
    python3 \
    python3-dev \
    python3-pip \
    openjdk-8-jre \
    openjdk-11-jre \
    openjdk-16-jre \
    libmysqlclient-dev && \
    pip3 install -r /crafty_web/requirements.txt && \
    apt-get clean

COPY ./ /crafty_web
WORKDIR /crafty_web

EXPOSE 8000
EXPOSE 25500-25600

CMD ["python3", "crafty.py", "-c", "/crafty_web/configs/docker_config.yml"]