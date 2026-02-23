FROM node:25-bookworm

WORKDIR /app

# Install pnpm
RUN corepack enable

# Copy all files first
COPY . .

# Install dependencies
RUN pnpm install

# Build
RUN pnpm build

EXPOSE 18789

WORKDIR /app

CMD ["node", "dist/index.js", "gateway", "--bind", "0.0.0.0", "--port", "18789"]
