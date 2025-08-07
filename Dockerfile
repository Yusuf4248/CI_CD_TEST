FROM node:alpine AS builder
WORKDIR /app
ADD package*.json ./
RUN npm ci
ADD . .
RUN npm run build --prod

FROM node:alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
ADD packeage*.json ./
RUN npm ci --omit-dev
CMD [ "ndoe", "./dist/main.js" ]