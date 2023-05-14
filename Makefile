yaml = ./srcs/docker-compose.yml

all: 
	docker-compose -f $(yaml) up -d --build

nginx:
	docker exec -it nginx sh

mariadb:
	docker exec -it mariadb sh

wordpress:
	docker exec -it wordpress sh

stop:
	docker-compose -f $(yaml) stop

status:
	docker ps 

logs:
	docker-compose -f $(yaml) logs

clean:
	docker-compose -f $(yaml) down -v
	rm -rf /home/sgamraou/data/wordpress_data/* /home/sgamraou/data/mariadb_data/*
	docker network prune -f

re: stop clean all
