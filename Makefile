DOCKER_NAME := jquest

run:
		rails server

install:
		bundle install
		npm install
		bower install

build-docker:
		docker build -t $(DOCKER_NAME) .

save-docker: build-docker
		docker save $(DOCKER_NAME) > $(DOCKER_NAME).tar

bundle-docker: save-docker
		gzip $(DOCKER_NAME).tar
