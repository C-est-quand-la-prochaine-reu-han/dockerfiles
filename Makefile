NAME=ft_transcendence

# postgresql : postgresql container
# api : api server
# pong : game server
# web : front-end nginx/apache serving css, js, images and various static resources
# reverse-proxy : reverse proxy holding everything related to security (and entrypoint of the infrastructure)

IMAGES=reverse-proxy web pong api postgresql
IMAGES_NAME=$(addprefix $(NAME)-, $(IMAGES))
CONTAINERS=$(addsuffix -1,$(IMAGES))
VOLUMES=postgresql static
VOLUMES_NAME=$(addprefix $(NAME)_, $(VOLUMES))

all: $(NAME)

$(NAME):
	mkdir -p $(HOME)/transcendence/static
	mkdir -p $(HOME)/transcendence/database
	docker build -t django srcs/utils/django/
	docker compose -p $(NAME) --file srcs/docker-compose.yml up --detach

stop:
	docker compose -p $(NAME) --file srcs/docker-compose.yml down

fclean: clean
	rm /home/atu/transcendence/ -rf
	docker volume rm $(VOLUMES_NAME) --force

clean: stop
	docker image rm $(IMAGES_NAME) --force

re: fclean
	docker compose --project-name $(NAME) --file srcs/docker-compose.yml up --force-recreate --pull always --quiet-pull --remove-orphans --renew-anon-volumes --build --detach

.PHONY: $(NAME)
