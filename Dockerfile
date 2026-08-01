FROM alpine:3.24.1

RUN apk add --no-cache tzdata curl jq nmap redis rsync openssh-client
