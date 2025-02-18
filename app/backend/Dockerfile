FROM debian:bullseye-slim
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
COPY dist/linux/backend ./
RUN chmod +x ./backend
EXPOSE 3000
CMD ["./backend"]
