FROM alpine:3.19.1 
ENV TIMEZONE=Europe/Brussels
RUN apk add alpine-conf curl jq htop
RUN setup-timezone -z $TIMEZONE
