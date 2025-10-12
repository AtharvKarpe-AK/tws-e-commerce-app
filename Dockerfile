# use image for node

FROM node:18-alpine AS builder

# Create workdirectory

WORKDIR /app

# install dependies

RUN apk add --no-cache python3 make g++

# copy json package files

COPY package*.json ./

# install npm ci: clean install

RUN npm ci

# copy project files

COPY . .

# create build for whole files

RUN npm run build

#stage 2: productio stage, here will copy all installed files

FROM node:18-alpine AS runner

# Set working directory

WORKDIR /app

# Copy necessary files from builder stage, talk to developer for this

COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

# Set environment variable

ENV NODE_ENV=production
ENV PORT=3000

# Expose the port the app runs on

EXPOSE 3000

# Run the application, server.js is the file present in directory to serve the application

CMD ["node","server.js"]
