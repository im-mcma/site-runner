# -------------------------------
# Dockerfile ساده و خودکار ZaneOps
# منطقه زمانی: Asia/Tehran
# پورت داشبورد: 10000
# -------------------------------

FROM ubuntu:22.04

# تنظیم محیط غیر تعاملی
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

# اجرای اسکریپت نصب ZaneOps با root
RUN curl -fsSL https://cdn.zaneops.dev/install.sh | bash

# ایجاد کاربر معمولی برای امنیت
RUN useradd -m zaneops && echo "zaneops ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# سوئیچ به کاربر معمولی
USER zaneops
WORKDIR /home/zaneops

# باز کردن پورت 10000 برای داشبورد وب
EXPOSE 10000

# دستور شروع کانتینر
CMD ["zaneops"]
