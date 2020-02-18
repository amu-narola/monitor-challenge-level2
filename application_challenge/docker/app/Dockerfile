FROM lambci/lambda:build-ruby2.5
RUN yum -y install mysql-devel
COPY ./docker/app/docker-entrypoint.sh /
RUN mkdir -p /var/task/lib
RUN mkdir /app
COPY ./Gemfile* /
RUN cp /usr/lib64/mysql/*.so.* /var/task/lib/
WORKDIR /app
RUN gem install bundler
RUN bundle config --local build.mysql2 --with-mysql2-config=/usr/lib64/mysql/mysql_config
RUN bundle config --local silence_root_warning true
RUN bundle install --path vendor/bundle

ENTRYPOINT ["/docker-entrypoint.sh"]
