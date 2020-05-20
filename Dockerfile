FROM ruby:2.6.4
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH /root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:$PATH
RUN mkdir /server
ENV APP_ROOT /server
WORKDIR $APP_ROOT

ADD Gemfile ./Gemfile
ADD Gemfile.lock ./Gemfile.lock
RUN bundle install
ADD . .
