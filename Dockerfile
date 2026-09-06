FROM node:20-alpine AS base
RUN apk add --no-cache gcompat
#COPY /app/my-app0302.tar.gz /app01/ 

COPY /my-app.tar.gz /app01/ 
WORKDIR /app01
RUN ls
RUN tar -xzf  my-app.tar.gz  &&  npm ci --omit=dev
FROM base AS runner



WORKDIR /app01

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 hono



USER hono
EXPOSE 3000

CMD ["node", "/app01/dist/index.js"]
