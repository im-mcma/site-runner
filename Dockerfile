# -------------------------------
# Dockerfile ZaneOps بدون systemctl
# منطقه زمانی: Asia/Tehran
# پورت: 10000
# -------------------------------

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tehran

# نصب پیش‌نیازها
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    python3-pip \
    postgresql-client \
    tzdata \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# ایجاد کاربر معمولی
RUN useradd -m zaneops && echo "zaneops ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER zaneops
WORKDIR /home/zaneops

# دانلود اسکریپت نصب و اصلاح اجرای foreground
RUN curl -fsSL https://cdn.zaneops.dev/install.sh -o install.sh && \
    sed -i 's/systemctl start /# systemctl start /g' install.sh && \
    sed -i 's/systemctl enable /# systemctl enable /g' install.sh && \
    bash install.sh

# باز کردن پورت 10000 برای وب
EXPOSE 10000

# اجرای ZaneOps در foreground
CMD ["zaneops", "--no-daemon", "--port", "10000"]
