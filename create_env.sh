#!/bin/bash

# Get the existing .env.example file
env_file="./.env.example"

# Read existing keys from file
app_keys=$(grep -oP '^APP_KEYS=\K.*' $env_file)
api_token_salt=$(grep -oP '^API_TOKEN_SALT=\K.*' $env_file)
admin_jwt_secret=$(grep -oP '^ADMIN_JWT_SECRET=\K.*' $env_file)
transfer_token_salt=$(grep -oP '^TRANSFER_TOKEN_SALT=\K.*' $env_file)
jwt_secret=$(grep -oP '^JWT_SECRET=\K.*' $env_file)
database_password=$(grep -oP '^DATABASE_PASSWORD=\K.*' $env_file)

# Generate new keys if existing ones are empty
if [ -z "$app_keys" ]; then
  app_keys=$(openssl rand -base64 32 | tr -d '\n' | fold -w 32 | paste -sd ',' -)
fi
if [ -z "$api_token_salt" ]; then
  api_token_salt=$(openssl rand -base64 32)
fi
if [ -z "$admin_jwt_secret" ]; then
  admin_jwt_secret=$(openssl rand -base64 32)
fi
if [ -z "$transfer_token_salt" ]; then
  transfer_token_salt=$(openssl rand -base64 32)
fi
if [ -z "$jwt_secret" ]; then
  jwt_secret=$(openssl rand -base64 32)
fi
if [ -z "$database_password" ]; then
  database_password=$(openssl rand -base64 12)
fi

# Write to .env file
cat > .env <<EOF
#Strapi Mode Command
#COMMAND=npm install && npm run build && npm run start
COMMAND=npm install && npm run build && npm run develop

#Docker
APP_NAME=strapi-docker-starter

# Phpmyadmin Port
PMA_PORT=8080

#Strapi
HOST=0.0.0.0
PORT=1337
APP_KEYS=$app_keys
API_TOKEN_SALT=$api_token_salt
ADMIN_JWT_SECRET=$admin_jwt_secret
TRANSFER_TOKEN_SALT=$transfer_token_salt
JWT_SECRET=$jwt_secret

# Database
DATABASE_CLIENT=mysql
DATABASE_HOST=db
DATABASE_PORT=3306
DATABASE_NAME=name
DATABASE_USERNAME=username
DATABASE_PASSWORD=$database_password
DATABASE_SSL=false

EOF

echo "New .env file generated as .env"