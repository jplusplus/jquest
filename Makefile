DOCKER_NAME := jquest
HEROKU_APP := jquest

run:
		rails server

install:
		bundle install
		npm install
		bower install

migrate-with-docker: DATABASE_URL := $(shell heroku config:get DATABASE_URL -a ${HEROKU_APP})
migrate-with-docker:
		docker run -e DATABASE_URL=${DATABASE_URL} -it ${HEROKU_APP} bin/init

migrate-with-local: DATABASE_URL := $(shell heroku config:get DATABASE_URL -a ${HEROKU_APP})
migrate-with-local:
		DATABASE_URL=${DATABASE_URL} \
		RACK_ENV=production \
		RAILS_ENV=production \
		SECRET_KEY_BASE=$(shell openssl rand -base64 32) \
		rake db:version

deploy: build-docker migrate-with-docker
		docker tag $(DOCKER_NAME) registry.heroku.com/$(HEROKU_APP)/web
		docker push registry.heroku.com/$(HEROKU_APP)/web

build-docker:
		docker build -t $(DOCKER_NAME) .

save-docker: build-docker
		docker save $(DOCKER_NAME) > $(DOCKER_NAME).tar

bundle-docker: save-docker
		gzip $(DOCKER_NAME).tar
