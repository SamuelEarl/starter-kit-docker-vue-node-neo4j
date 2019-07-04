# ==============================
# DEVELOPMENT
# ==============================
# `make dev`
# Start the development containers. If no containers exist, then this command will create new containers.
dev:
	docker-compose -f docker-compose.dev.yml up
	# The `-f` flag specifies the filename that should be used in the docker-compose command.

# `make dev-rebuild`
# If you want to rebuild the images without using the cache, then run this command first,
# then run `make dev` to start the newly built development containers.
dev-rebuild:
	docker-compose -f docker-compose.dev.yml build --no-cache

# `make dev-daemon`
dev-daemon:
	docker-compose -f docker-compose.dev.yml up -d
	# The `-d` flag will run the app in daemon mode (i.e., in the background).

# `make dev-down`
# This will stop and delete any running containers. It deletes containers and networks, but not volumes and images.
dev-down:
	docker-compose -f docker-compose.dev.yml down


# ==============================
# TEST
# ==============================
# `make test`
test:
	docker-compose -f docker-compose.test.yml up


# ==============================
# STAGING
# ==============================
# `make staging`
staging:
	docker-compose -f docker-compose.staging.yml up


# ==============================
# PRODUCTION
# ==============================
# `make prod`
# Start the production containers in daemon mode. If no containers exist, then this command will create new containers.
prod:
	docker-compose -f docker-compose.prod.yml up
	# The `-f` flag specifies the filename that should be used in the docker-compose command.

# `make prod-rebuild`
# If you want to rebuild the images without using the cache, then run this command first,
# then run `make prod` to start the newly built production containers.
prod-rebuild:
	docker-compose -f docker-compose.prod.yml build --no-cache

# `make prod-daemon`
prod-daemon:
	docker-compose -f docker-compose.prod.yml up -d
	# The `-d` flag runs the app in daemon mode (i.e., in the background).

# `make prod-down`
# This will stop and delete any running containers. It deletes containers and networks, but not volumes and images.
prod-down:
	docker-compose -f docker-compose.prod.yml down
