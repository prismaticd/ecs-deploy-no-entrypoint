FROM  silintl/ecs-deploy:latest

MAINTAINER Benoit Chabord <>

RUN apk --no-cache tar && \
curl -L https://github.com/course-hero/slacktee/archive/v1.2.15.tar.gz | tar -xzv slacktee-1.2.15/slacktee.sh --strip=1 && \
mv slacktee.sh /usr/bin/

ENTRYPOINT []
