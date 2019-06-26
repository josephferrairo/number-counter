FROM ruby:2.5.5

RUN apt-get update -qq && apt-get install -y build-essential redis-server

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ENV BUNDLER_VERSION 2.0.1
RUN gem install bundler
ADD Gemfile* $APP_HOME/
RUN bundle install --without development test

ADD . $APP_HOME

EXPOSE 4567
