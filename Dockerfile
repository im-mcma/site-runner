# -------------------------------
# Dockerfile ساده و خودکار ZaneOps
# منطقه زمانی: Asia/Tehran
# -------------------------------

FROM ubuntu:22.04

# تنظیم محیط غیر تعاملی برای نصب بسته‌ها
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tehran

# نصب پیش‌نیازها
RUN apt-get update && apt-get install -y \
    curl \
    git \
    docker.io \
    docker-compose \
    postgresql \
    postgresql-client \
    tzdata \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# ایجاد کاربر برای ZaneOps
RUN useradd -m zaneops && echo "zaneops ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER zaneops
WORKDIR /home/zaneops

# دانلود و نصب ZaneOps (اسکریپت رسمی)
RUN curl -fsSL https://cdn.zaneops.dev/install.sh | bash

# باز کردن پورت داشبورد وب
EXPOSE 10000

# دستور شروع کانتینر
CMD ["zaneops"]
