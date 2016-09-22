DOCKER_NAME := jquest
APP := jquest

run:
		bundle exec rails server

install:
		bundle install
		npm install
		bower install

migrate-with-docker: config-env
		docker run ${CONFIG} -it ${DOCKER_NAME} bin/init

migrate-with-local:
		DATABASE_URL=$(shell heroku config:get DATABASE_URL -a ${APP}) \
		RACK_ENV=production \
		RAILS_ENV=production \
		SECRET_KEY_BASE=$(shell openssl rand -base64 32) \
		rails db:version

pg-pull:
		dropdb jquest
		heroku pg:pull DATABASE_URL jquest -a ${APP}

deploy: build-docker tag-docker push-docker

tag-docker:
		docker tag $(DOCKER_NAME) registry.heroku.com/$(APP)/web

push-docker:
		docker push registry.heroku.com/$(APP)/web

build-docker:
		docker build -t $(DOCKER_NAME) --build-arg ASSET_HOST=$(shell heroku config:get ASSET_HOST  -a ${APP}) .

save-docker: build-docker
		docker save $(DOCKER_NAME) > $(DOCKER_NAME).tar

bundle-docker: save-docker
		gzip $(DOCKER_NAME).tar

config-env:
		$(eval CONFIG := $(shell heroku config -s -a ${APP} | awk '{print "-e " $$0 }') )

run-docker: config-env
		docker run ${CONFIG} --user=root --dns=8.8.8.8  -p 3003:3000 -it ${DOCKER_NAME} bash
