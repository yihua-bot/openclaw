FROM node:22-bookworm

WORKDIR /app

# Copy package files
COPY package.json package-lock.json* ./

# Install dependencies (use npm as pnpm lock file doesn't exist)
RUN if [ -f "package-lock.json" ]; then \
      npm ci; \
    else \
      npm install; \
    fi

# Copy source
COPY . .

# Build
RUN npm run build

EXPOSE 18789

WORKDIR /app

CMD ["node", "dist/index.js", "gateway", "--bind", "0.0.0.0", "--port", "18789"]
