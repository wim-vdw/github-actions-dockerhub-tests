FROM alpine:3.19.1 
ENV TIMEZONE=Europe/Brussels
RUN apk add alpine-conf
RUN setup-timezone -z $TIMEZONE
