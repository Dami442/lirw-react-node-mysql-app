#!/bin/bash
# Install backend production dependencies
cd /var/www/lirw-app/backend
npm install --production

# Configure backend environment variables for MySQL connection
cat <<EOT > .env
PORT=5000
NODE_ENV=production
DB_HOST=localhost
DB_USER=lirw_user
DB_PASSWORD=LirwSecurePass123!
DB_NAME=lirw_db
DB_PORT=3306
EOT

# Ensure serve is installed globally for frontend static hosting
npm install -g serve