# ===================================== #
# === STAGE 1: Prepare dependencies === #
# ===================================== #

FROM node:20-alpine AS dependencies
WORKDIR /app

COPY package.json package-lock.json ./
# Since we need to use node_modules inside docker image, it should be minimal
RUN npm ci --omit=dev


# =============================== #
# === STAGE 2: Production app === #
# =============================== #

FROM node:20-alpine AS production
WORKDIR /app

# Copy only production node_modules from stage 1
COPY --from=dependencies /app/node_modules ./node_modules
# Copy application source code
COPY . .

# Create a non-root user and switch to it
# Running as root inside a container is a security risk
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3200

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:3200/health || exit 1

CMD ["node", "server.js"]