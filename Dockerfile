# Dockerfile for bugmark/exchange
#
# To launch:
# term1> docker run --name pgdb -e POSTGRES_PASSWORD=pwd postgres:11
# term2> docker run --name bgmk --link pgdb:postgres bin/rails server
#
# Building the image
# > docker build . -t bugmark/exchange
# > docker push bugmark/exchange

FROM ruby:2.6

MAINTAINER Andy Leak <andy@r210.com>

RUN apt-get update -yqq && \
    apt-get install -yqq --no-install-recommends nodejs

ENV     APP_HOME /usr/src/app
RUN     mkdir -p $APP_HOME
COPY    Gemfile* $APP_HOME/
WORKDIR $APP_HOME
RUN     bundle install

COPY . $APP_HOME


