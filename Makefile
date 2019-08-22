build: down
	docker-compose build
up:
	docker-compose up -d postgres
	docker-compose up -d spring
	docker-compose run --rm app /bin/bash -c "rails db:create && rails db:migrate"
dev:
	docker-compose run -p 3000:3000 --rm app rails s
migrate_dev:
	docker-compose run -p 3000:3000 --rm app /bin/bash -c "rails db:create && rails db:migrate && rails s"
seed:
	docker-compose run --rm app /bin/bash -c "rails db:migrate:reset && rails db:seed"
console:
	docker-compose run --rm app rails c	
down:
	docker-compose down
rspecs:
	docker-compose run --rm app spring rspec
rubocop:
	docker-compose run --rm app spring rubocop -a
routes:
	docker-compose run --rm app rails routes
