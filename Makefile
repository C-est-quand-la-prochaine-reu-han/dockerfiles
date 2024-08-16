NAME=ft_transcendence

# reverse-proxy : reverse proxy holding everything related to security (and entrypoint of the infrastructure)
# web : front-end nginx/apache serving css, js, images and various static resources
# pong : game server
# api : api server
# postgresql : postgresql container

IMAGES=reverse-proxy web pong api postgresql
IMAGES_NAME=$(addprefix $(NAME)-, $(IMAGES)) django
CONTAINERS=$(addsuffix -1,$(IMAGES))
VOLUMES=postgresql static
VOLUMES_NAME=$(addprefix $(NAME)_, $(VOLUMES))

all: $(NAME)

$(NAME): volume image
	docker compose -p $(NAME) --file srcs/docker-compose.yml up --detach

# Custom images are built here
image:
	docker build -t django srcs/utils/django/

# Volumes/bind-mounts preparation
volume:
	mkdir -p $(addprefix $(HOME)/$(NAME)/,$(VOLUMES))

stop:
	docker compose -p $(NAME) --file srcs/docker-compose.yml down

clean: stop
	docker image rm $(IMAGES_NAME) --force

fclean: clean
	docker volume rm $(VOLUMES_NAME) --force
	docker run -v $(HOME)/$(NAME):/$(NAME) alpine rm -rf $(addprefix $(NAME)/,$(VOLUMES)) || exit 0
	rm -rf $(HOME)/$(NAME)

re: fclean all

help:
	@echo all
	@echo '	Run all the services.'
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
	@echo volume
	@echo '	This rule creates the directories holding the bind mounts.'

.PHONY: $(NAME)
