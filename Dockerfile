
FROM node:alpine3.22

WORKDIR /tmp

COPY index.js index.html package.json ./

EXPOSE 3000/tcp

RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    chmod +x index.js && \
    npm install && \
    adduser -D -u 10014 appuser && \
    chown -R appuser:appuser /tmp

# 使用非 root 用户运行容器
USER 10014

CMD ["node", "index.js"]
