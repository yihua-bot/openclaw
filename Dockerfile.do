FROM node:22-bookworm

# Install pnpm
RUN corepack enable

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml .npmrc ./
COPY ui/package.json ./ui/package.json
COPY patches ./patches
COPY scripts ./scripts

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source
COPY . .

# Build
RUN pnpm build

EXPOSE 18789

WORKDIR /app

CMD ["node", "dist/index.js", "gateway", "--bind", "0.0.0.0", "--port", "18789"]
