# Stage 1: Build Frontend
FROM node:18-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Production Server
FROM node:18-alpine
WORKDIR /app

# Install root dependencies (likely shared)
COPY package*.json ./
RUN npm install --production

# Install server dependencies
COPY server/package*.json ./server/
RUN cd server && npm install --production

# Copy built frontend
COPY --from=build /app/dist ./dist

# Copy backend code
COPY server/ ./server/

# Copy Environment configs
# (In production, you usually inject these via env vars, but copying .env if it exists is a fallback, 
# though docker-compose usually handles mounting it)
# COPY .env .env

EXPOSE 3001
CMD ["node", "server/index.js"]
