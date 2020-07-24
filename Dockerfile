FROM nginx:stable-alpine

COPY index.html /usr/share/nginx/html
# override nginx default config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]