FROM nginx:1.24
RUN apt update && \
    apt install unzip && \
    rm -rf /usr/share/nginx/html/* && \
    rm -rf /etc/nginx/conf.d/*
WORKDIR /usr/share/nginx/html/
ADD https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip .
RUN unzip frontend-v3.zip
COPY nginx.conf /etc/nginx/nginx.conf
WORKDIR  /etc/nginx/
CMD ["bash","-c","envsubst '$catalogue,$user,$cart,$shipping,$payment' < nginx.conf > nginx1.conf && mv nginx1.conf nginx.conf && nginx  -g 'daemon off;'"]