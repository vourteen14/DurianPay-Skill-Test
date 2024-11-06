FROM nginx:latest

WORKDIR /var/www

COPY hello.txt /var/www/
COPY nginx.conf /etc/nginx/nginx.conf
RUN chown -R nginx:nginx /var/www

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]