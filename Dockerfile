# Dockerfile for bugmark/exchange
#
# To launch:
# term1> docker run --name pgdb -e POSTGRES_PASSWORD=postgres postgres:11
# term2> docker run --name bgmk --link pgdb:postgres -p 3333:3000 bugmark/exchange 
# term3> curl localhost:3333
# browser> http://localhost:3333
#
# Building the image
# > docker build . -t bugmark/exchange
# > docker push bugmark/exchange

FROM ruby:2.6

MAINTAINER Andy Leak <andy@r210.com>

RUN apt-get update -yqq && \
    apt-get install -yqq --no-install-recommends nodejs postgresql-client

ENV     APP_HOME /usr/src/app
RUN     mkdir -p $APP_HOME
COPY    Gemfile* $APP_HOME/
WORKDIR $APP_HOME
RUN     bundle install
EXPOSE  3000

COPY . $APP_HOME

CMD ["script/docker/cmd.bash"]

