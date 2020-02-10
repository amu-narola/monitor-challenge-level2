FROM ruby:2.5.5
RUN apt-get update && apt-get install -y apt-utils mariadb-client
COPY ./docker/app/docker-entrypoint.sh /
RUN mkdir /app
COPY ./Gemfile* /
WORKDIR /app
RUN gem install bundler
RUN BUNDLE_IGNORE_CONFIG=1 bundler install
