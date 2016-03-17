# jQuest

## Install

Assuming you already installed [Ruby] and [Bower] on your computer.

    git clone git@github.com:jplusplus/jquest.git && cd jquest
    bundle install
    bower install

## Setup and populate database

    rake db:setup

## Run

    rails server

## Deploy

Create (and edit) `docker-compose.yml` using the template:

    cp docker-compose.yml.example docker-compose.yml

This app comes with Docker settings that can be deployed on Heroku:

    heroku docker:release -a jquest



[Ruby]: https://www.ruby-lang.org/en/documentation/installation/
[Bower]: http://bower.io/#install-bower
