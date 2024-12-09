all: build_run

build_run:
	clear
	@echo "Building and starting ..."
	docker compose --env-file default.env up -d --build

down:
	@echo "Stopping containers ..."
	docker compose down

rm:
	@echo "Removing containers ..."
	docker compose down
	docker compose rm
	sudo rm -fr dolibarr_mariadb
