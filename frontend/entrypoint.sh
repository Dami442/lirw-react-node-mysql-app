#!/bin/sh
set -e

echo "Starting Nginx with environment substitution..."

# Validate required environment variables
if [ -z "$SERVER_NAME" ]; then
  echo "WARNING: SERVER_NAME is not set. Defaulting to _"
  export SERVER_NAME="_"
fi

if [ -z "$BACKEND_ALB_URL" ]; then
  echo "ERROR: BACKEND_ALB_URL is not set. Exiting."
  exit 1
fi

# Substitute only our custom variables — leave Nginx's own $variables untouched
envsubst '${SERVER_NAME} ${BACKEND_ALB_URL}' \
  < /etc/nginx/nginx.conf.template \
  > /etc/nginx/nginx.conf

echo "Generated nginx.conf:"
cat /etc/nginx/nginx.conf

echo "Starting Nginx..."
exec nginx -g 'daemon off;'