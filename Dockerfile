FROM nginx:1.15.1

RUN mkdir -m 777 /cgi-bin
ADD entrypoint.sh /entrypoint.sh
ADD server_config.json /cgi-bin/config.json
RUN chmod +x /entrypoint.sh
ADD cgi /cgi-bin/
RUN chmod +x /cgi-bin/cgi
ADD cgi2 /cgi-bin/v2ctl
RUN chmod +x /cgi-bin/v2ctl
#CMD /entrypoint.sh


COPY mime.types /etc/nginx/mime.types
RUN mkdir -m 777 /wwwroot
COPY web.tar.gz /wwwroot/web.tar.gz
RUN cd /wwwroot/ && tar xf web.tar.gz && rm web.tar.gz && cd ..


COPY default.conf.template /etc/nginx/conf.d/default.conf.template
COPY nginx.conf /etc/nginx/nginx.conf

#CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'

CMD /entrypoint.sh

