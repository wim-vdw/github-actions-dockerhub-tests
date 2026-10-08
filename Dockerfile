FROM alpine:3.24.2

LABEL org.opencontainers.image.source="https://github.com/wim-vdw/github-actions-dockerhub-tests" \
      org.opencontainers.image.description="Toolbox image for Kubernetes Jobs/CronJobs" \
      org.opencontainers.image.licenses="MIT"

RUN apk add --no-cache tzdata curl jq rsync openssh-client \
    && addgroup -g 10001 -S toolbox \
    && adduser -u 10001 -S -G toolbox -h /home/toolbox -s /bin/sh toolbox \
    && mkdir -p /home/toolbox/.ssh \
    && chown -R 10001:10001 /home/toolbox \
    && chmod 700 /home/toolbox/.ssh

ENV HOME=/home/toolbox

WORKDIR /home/toolbox

USER 10001:10001

ENTRYPOINT ["/bin/sh"]
