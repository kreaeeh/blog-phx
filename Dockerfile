# ./Dockerfile

# Extend from the official Elixir image
FROM elixir:1.12.2

ENV PHX_VERSION 1.5.12
ENV NODE_MAJOR 14.15.14



# Create app directory and copy the Elixir projects into it
ENV APP_HOME /blog
RUN mkdir $APP_HOME
WORKDIR $APP_HOME


RUN mix local.hex --force \
  && mix archive.install --force hex phx_new 1.5.12 \
  && apt-get update \
  && curl -sL https://deb.nodesource.com/setup_12.x | bash \
  && apt-get install -y apt-utils \
  && apt-get install -y nodejs \
  && apt-get install -y build-essential \
  && apt-get install -y inotify-tools \
  && mix local.rebar --force




EXPOSE 4000

