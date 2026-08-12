#!/bin/bash
# Stop any currently running PM2 instances
pm2 stop all || true
pm2 delete all || true

# 1. Start Node.js Express Backend API (Port 5000)
cd /var/www/lirw-app/backend
if [ -f "index.js" ]; then
  pm2 start index.js --name "lirw-backend-api"
elif [ -f "server.js" ]; then
  pm2 start server.js --name "lirw-backend-api"
else
  pm2 start npm --name "lirw-backend-api" -- start
fi

# 2. Serve React Frontend static build (Port 80)
cd /var/www/lirw-app/frontend
pm2 start "serve -s build -l 80" --name "lirw-frontend"

# Save PM2 process list across system reboots
pm2 save