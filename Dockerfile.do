FROM node:22-bookworm

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml .npmrc ./

# Install pnpm and dependencies
RUN corepack enable && pnpm install --frozen-lockfile

# Copy source
COPY . .

# Build
RUN pnpm build

EXPOSE 18789

WORKDIR /app

CMD ["node", "dist/index.js", "gateway", "--bind", "0.0.0.0", "--port", "18789"]
