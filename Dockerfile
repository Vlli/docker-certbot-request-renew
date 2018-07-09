FROM certbot/dns-route53
RUN mkdir -p /opt/scripts && \
    apk update && \
    apk upgrade && \
    apk add bash
ENV script_dir /opt/scripts
ENV PREFERRED_CHALLENGES dns-01
ENV SERVER https://acme-v02.api.letsencrypt.org/directory
WORKDIR ${script_dir}
ADD create_or_renew.sh ${script_dir}
ENTRYPOINT ${script_dir}/create_or_renew.sh $DOMAINS