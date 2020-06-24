FROM alpine
RUN apk add php-cli php-curl php-json unzip
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /
ADD https://github.com/Netatmo/Netatmo-API-PHP/archive/master.zip /tmp/
RUN unzip /tmp/master.zip -d /
COPY cron.sh /
COPY my_weather_docker.php /
RUN echo "*/10 * * * * /usr/bin/php /my_weather_docker.php" > /etc/crontabs/root
RUN rm /tmp/master.zip
ENTRYPOINT ["/init"]
CMD ["/cron.sh"]
