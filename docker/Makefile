all: build_run

build_run:
	@echo ""
	@echo "Building and starting ..."
	docker compose --env-file default.env up --build

down:
	@echo ""
	@echo "Stopping containers ..."
	docker compose down

rm:
	@echo ""
	@echo "Removing containers ..."
	docker compose down
	docker compose rm
	sudo rm -fr dolibarr_mariadb

install:
	@echo ""
	@echo "Installing Dolibarr ..."
	mkdir dolibarr_mariadb
	make build_run