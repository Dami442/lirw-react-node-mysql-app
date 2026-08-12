#!/bin/bash
set -e

APP_DIR="/var/www/lirw-app"

echo "Creating application directory if missing..."
mkdir -p "$APP_DIR/backend"

# Ensure global CLI tools are installed (requires root)
if ! command -v serve &> /dev/null; then
    echo "Installing global dependencies..."
    npm install -g serve
fi

echo "Installing production dependencies for backend..."
cd "$APP_DIR/backend"
npm install --production

echo "Configuring environment variables..."
cat <<EOT > .env
PORT=5000
NODE_ENV=production
DB_HOST=localhost
DB_USER=lirw_user
DB_PASSWORD=LirwSecurePass123!
DB_NAME=lirw_db
DB_PORT=3306
EOT

echo "Fixing file ownership and permissions for ec2-user..."
chown -R ec2-user:ec2-user "$APP_DIR"
chmod 600 "$APP_DIR/backend/.env"