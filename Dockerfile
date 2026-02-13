# Stage:1 Use latest image

FROM node:22-alpine AS builder

#Create working directory

WORKDIR /app

# Create non-root user as per alpine syntax

RUN addgroup -S tws-group && adduser -S tws-user -G tws-group

#install necessary build dependencies

RUN apk add --no-cache python3 make g++

#Copy packages

COPY package*.json ./

#Install dependencies

RUN npm ci

#Copy project files

COPY . .

#Build application for Next.js

RUN npm run build

#Stage:2 Production stage

FROM node:22-alpine AS runner

#Set working directory

WORKDIR /app

#create same user in production stage

RUN addgroup -S tws-group && adduser -S tws-user -G tws-group

#Copy necessary files from builder stage, here need to change owenership of these files because initially copied files through root user now using another user to avoid permission owenership errors

COPY --from=builder --chown=tws-user:tws-group /app/.next/standalone ./
COPY --from=builder --chown=tws-user:tws-group /app/.next/static ./.next/static
COPY --from=builder --chown=tws-user:tws-group /app/public ./public

# Set environment variables

ENV NODE_ENV=production
ENV PORT=3000

# Switch user

USER tws-user

# Expose to port

EXPOSE 3000

# Command to run application

CMD ["node", "server.js"]
