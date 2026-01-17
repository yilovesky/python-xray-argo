FROM python:3.10-alpine

# 1. 强制不缓冲日志：这是解决“没日志”的关键，让 print 立即显示
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY . .

# 2. 关键补丁：
# - gcompat: 解决二进制文件在 Alpine 跑不起来的问题
# - ca-certificates: 解决 HTTPS 下载报错的问题
RUN apk update && \
    apk --no-cache add openssl bash curl gcompat ca-certificates && \
    pip install --no-cache-dir -r requirements.txt

# 3. 赋予权限
RUN chmod +x app.py

EXPOSE 3000

# 4. 启动指令
CMD ["python3", "app.py"]
