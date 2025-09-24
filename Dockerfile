# مرحله اول: پایه
FROM ubuntu:22.04

# نصب پیش‌نیازها
RUN apt-get update && apt-get install -y \
    curl \
    git \
    docker.io \
    docker-compose \
    postgresql \
    && rm -rf /var/lib/apt/lists/*

# اضافه کردن کاربر
RUN useradd -m zaneops

USER zaneops
WORKDIR /home/zaneops

# دانلود و نصب ZaneOps
RUN curl -fsSL https://cdn.zaneops.dev/install.sh | bash

# در صورت نیاز پورت‌ها را باز کنید
EXPOSE 10000

# دستور اجرا
CMD ["zaneops"]
