FROM rrcfesc/lamp:7.2

ENV RIOXYGEN_USER "rioxygen"
ENV MAGENTO_VERSION "2.3.4"

#USER $RIOXYGEN_USER
ADD auth.json /root/.composer/auth.json
RUN composer create-project --repository=https://repo.magento.com/ magento/project-community-edition=$MAGENTO_VERSION . -vvv
RUN find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
RUN find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
RUN chmod u+x bin/magento
RUN pwd && ls -al;
RUN chown -R $RIOXYGEN_USER:www-data .