all: 
	docker-compose -f ./srcrs/docker-compose.yml up -d

nginx:
	docker exec -it nginx sh

mariadb:
	docker exec -it mariadb sh

wordpress:
	docker exec -it wordpress sh

status:
	docker ps 

clean:
	docker-compose -f ./srcrs/docker-compose.yml down -v
	rm -rf /home/sgamraou/data/wordpress_data/* /home/sgamraou/data/mariadb_data/*

re: clean all
