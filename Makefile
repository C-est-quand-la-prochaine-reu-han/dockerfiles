include srcs/.env

NAME=ft_transcendence

# reverse-proxy : reverse proxy holding everything related to security (and entrypoint of the infrastructure)
# web : front-end nginx/apache serving css, js, images and various static resources
# pong : game server
# api : api server
# postgresql : postgresql container

IMAGES=reverse-proxy web pong api postgresql api-mock
IMAGES_NAME=$(addprefix $(NAME)-, $(IMAGES)) django

CONTAINERS=$(addsuffix -1,$(IMAGES))

VOLUMES=postgresql static api pong
VOLUMES_NAME=$(addprefix $(NAME)_, $(VOLUMES))

all: $(NAME)

$(NAME): volume image
	docker compose -p $(NAME) --file srcs/docker-compose.yml up --detach

webdev:
	docker compose -p $(NAME) --file srcs/docker-compose-webdev.yml up --detach
	firefox localhost &

image:
	docker build -t django srcs/images/django/

django-test: image
	docker container rm --force django
	[ -d ./venv ] || virtualenv venv || python -m venv venv
	source venv/bin/activate && pip3 install django
	[ -d ./tests ] || (source venv/bin/activate && django-admin startproject demo && mv demo tests)
	docker run --env PORT=8080 --env WSGI_FILE='demo.wsgi' --volume ./tests/:/var/www/html --publish 80:8080 --detach --name=django django
	firefox http://localhost:80/

apidev: image
	docker container rm django
	@[ -z "$(API_ROOT_DIRECTORY)" ] || echo please export API_ROOT_DIRECTORY or set it in .env
	docker run --volume "$(API_ROOT_DIRECTORY)":/var/www/html --env PORT=8080 --env WSGI_FILE="$(API_WSGI_FILE)" --publish 80:8080 --name django django

volume:
	mkdir -p $(addprefix $(HOME)/$(NAME)/,$(VOLUMES))

stop:
	docker compose -p $(NAME) --file srcs/docker-compose.yml down

clean: stop
	rm venv -rf
	docker container rm --force django
	docker image rm $(IMAGES_NAME) --force

fclean: clean
	docker volume rm $(VOLUMES_NAME) --force
	docker run -v $(HOME)/$(NAME):/$(NAME) alpine rm -rf $(addprefix $(NAME)/,$(VOLUMES)) || exit 0
	rm -rf $(HOME)/$(NAME)

re: fclean all

help:
	@echo all
	@echo '	Run all the 5 services.'
	@echo
	@echo stop
	@echo '	Stop all the services but leave images and volumes intact.'
	@echo '	You can resume the execution by running make without argument later.'
	@echo
	@echo clean
	@echo '	Stop all the services and remove the images.'
	@echo '	Making the project again will apply the changes made in the Dockerfiles and configuration files.'
	@echo '	Data stored in the volumes (database, static content, user-uploaded files) will be kept.'
	@echo
	@echo fclean
	@echo '	Stop all the services, remove the images and wipe the volumes.'
	@echo '	Full reset, use with caution (especially if you spent a lot of time building a test database).'
	@echo
	@echo re
	@echo '	fclean + all'
	@echo
	@echo image
	@echo '	This rule build the custom images required by the project.'
	@echo
	@echo django-test
	@echo '	This rule build the django custom image required by the project.'
	@echo '	It then runs it, exposing the port 8080 and mounting a fake app that should be located in the directory ./tests'
	@echo '	If the app does not exists, it creates it. If you are not in a venv, or django is not installed, it will fail.'
	@echo
	@echo webdev
	@echo '	Runs the front-end container, and a mock of the API that will return dummy data.'
	@echo '	This lightweight version of the project lets you develop, debug or test the interface without caring about the back-end state.'
	@echo
	@echo volume
	@echo '	This rule creates the directories holding the bind mounts.'

.PHONY: $(NAME) webdev image django-test volume stop clean fclean re help
