DOCKER_NAME := jquest
HEROKU_APP := jquest

run:
		rails server

install:
		bundle install
		npm install
		bower install

deploy:
		bundle install
		make build-docker
		docker tag $(DOCKER_NAME) registry.heroku.com/$(HEROKU_APP)/web
		docker push registry.heroku.com/$(HEROKU_APP)/web

build-docker:
		docker build -t $(DOCKER_NAME) .

save-docker: build-docker
		docker save $(DOCKER_NAME) > $(DOCKER_NAME).tar

bundle-docker: save-docker
		gzip $(DOCKER_NAME).tar
