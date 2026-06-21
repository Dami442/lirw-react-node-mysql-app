# ========================================= #
# === STAGE 1: Build the Vite React App === #
# ========================================= #

#FROM node:20-alpine AS buildstage
FROM public.ecr.aws/docker/library/node:20-alpine AS buildstage
# Set working directory
WORKDIR /app
# Copy package files
COPY package.json package-lock.json ./
# Install dependencies
RUN npm ci
# Copy the rest of the application source code
COPY . .
# Declare the Build Argument required by Vite
ARG VITE_API_URL
# Expose it to the environment context so the 'npm run build' script sees it
ENV VITE_API_URL=$VITE_API_URL
# Build the application
RUN npm run build

# ================================= #
# === STAGE 2: Serve with Nginx === #
# ================================= #

#FROM nginx:alpine
FROM public.ecr.aws/nginx/nginx:alpine
# Remove default nginx config and static files
RUN rm -rf /usr/share/nginx/html/* && \
    rm -f /etc/nginx/conf.d/default.conf
# Copy built React files from Stage 1
COPY --from=buildstage /app/dist /usr/share/nginx/html
# Copy nginx template
COPY nginx.conf.template /etc/nginx/nginx.conf.template
# Copy and set permissions on entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
# Expose port 80
EXPOSE 80
# Use entrypoint to run envsubst then start nginx
CMD ["/entrypoint.sh"]