FROM alpine:3.22

RUN apk add --no-cache tzdata curl jq nmap nfs-utils
