DOCKER_NAME := jquest
HEROKU_APP := jquest

run:
		rails server

install:
		bundle install
		npm install
		bower install

migrate-heroku: DATABASE_URL := $(shell heroku config:get DATABASE_URL -a ${HEROKU_APP})
migrate-heroku:
		docker run -e DATABASE_URL=${DATABASE_URL} -it ${HEROKU_APP} bin/init

deploy: build-docker migrate-heroku
		docker tag $(DOCKER_NAME) registry.heroku.com/$(HEROKU_APP)/web
		docker push registry.heroku.com/$(HEROKU_APP)/web

build-docker:
		docker build -t $(DOCKER_NAME) .

save-docker: build-docker
		docker save $(DOCKER_NAME) > $(DOCKER_NAME).tar

bundle-docker: save-docker
		gzip $(DOCKER_NAME).tar
