###### pure graphite-api
FROM qnib/terminal:fd22

#ADD yum-cache/graphite-api /tmp/yum-cache/graphite-api
RUN dnf install -y libffi-devel cairo && \
    pip install --upgrade pip && \
    pip install graphite-api && \
    mkdir -p /var/lib/graphite

ADD etc/graphite-api.yaml /etc/graphite-api.yaml

## Diamond
ADD etc/diamond/collectors/NginxCollector.conf /etc/diamond/collectors/NginxCollector.conf

# gunicorn nginx
RUN dnf install -y python-gunicorn nginx
ADD etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD etc/consul.d/graphite-api.json /etc/consul.d/
ADD etc/nginx/conf.d/diamond.conf /etc/nginx/conf.d/
ADD etc/nginx/conf.d/graphite-api.conf /etc/nginx/conf.d/
ADD etc/supervisord.d/graphite-api.ini /etc/supervisord.d/graphite-api.ini
ADD etc/supervisord.d/nginx.ini /etc/supervisord.d/nginx.ini
