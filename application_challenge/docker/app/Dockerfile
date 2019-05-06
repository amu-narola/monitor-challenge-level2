FROM ruby:2.5.5
RUN apt-get update && apt-get install -y mysql-client
COPY ./docker/app/docker-entrypoint.sh /
RUN mkdir /app
WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]
