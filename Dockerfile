# Stage 1: Builder
FROM node:20.11.1-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Stage 2: Production Runtime
FROM node:20.11.1-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY package.json index.js ./
EXPOSE 3000
CMD ["node", "index.js"]
