docker build \
  --build-arg VITE_API_URL=/api \
  -t frontend-app .

docker run -p 80:80 \
  -e SERVER_NAME=localhost \
  -e BACKEND_ALB_URL=http://host.docker.internal:3200 \
  frontend-app

#docker run -p 80:80 \
#  -e SERVER_NAME=localhost \
#  -e BACKEND_ALB_URL=http://localhost:3200 \
#  frontend-app