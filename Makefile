.PHONY: clean
clean:
	docker-compose -p irrd down -v -t 1 --rmi local
	docker network prune -f

.PHONY: start
start: clean
	docker-compose -p irrd up --build --exit-code-from irrd

.PHONY: dump
dump:
	docker exec postgres pg_dump -d irrd -U irrd -w > irrdb.sql
