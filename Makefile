demo:
	osascript demo.scpt

vault:
	vault server --dev

postgres:
	./scripts/start-postgres.sh

cred:
	vault read database/creds/readonly

secure:
	vault lease revoke -prefix database/

1_configure_vault:
	-scripts/configure-vault.sh

2_create_users:
	-scripts/create-users.sh

3_generate_credentials:
	-scripts/generate-credentials.sh

clean:
	-@docker rm -f kevin-web-1
	-@docker rm -f kevin-web-2
	-@docker rm -f adam-web-1
	-@docker rm -f adam-web-2

app: clean
	-@cd app && sh launch-app-containers.sh

db:
	-@docker exec kevin-web-1 python manage.py recreate-db
	-@docker exec kevin-web-1 python manage.py seed-db

test:
	curl http://localhost:5000/users
	curl http://localhost:5001/users
	curl http://localhost:5002/users
	curl http://localhost:5003/users
