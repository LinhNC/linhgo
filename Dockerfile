# ---- Stage 1: Build Hugo Site ----
FROM hugomods/hugo:0.147.5 AS builder

WORKDIR /site
COPY . .

# Build the static site
RUN hugo --minify

# ---- Stage 2: Lightweight Nginx Server ----
FROM nginx:alpine

# Copy static files from builder
COPY --from=builder /site/public /usr/share/nginx/html

# Optional: custom Nginx config (remove if not used)
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
