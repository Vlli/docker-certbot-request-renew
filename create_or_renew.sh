#!/bin/bash   

RENEW=false

function renew_cert {
  echo "Renewing Certificates"
  certbot renew
}

function request_cert {
  echo "Try to request certificate $DOMAIN"
  certbot certonly \
    -d *.$DOMAIN_SUBST -d $DOMAIN_SUBST  \
    --preferred-challenges $PREFERRED_CHALLENGES \
    --server $SERVER \
    -m $MAIL \
    --dns-route53 \
    --agree-tos --no-eff-email --manual-public-ip-logging-ok
}

function create_or_renew {
  echo "Check if /etc/letsencrypt/live/$DOMAIN_SUBST exists"
  if [ -d "/etc/letsencrypt/live/$DOMAIN_SUBST" ]
  then
    echo "Certificate for $DOMAIN exists"
    echo "Queuing for renew"
    RENEW=true
  else
    echo "Certificate for $DOMAIN does not exist"
    echo "Obtaining certificate"
    request_cert
  fi
}

for i do
  echo "$i"
  DOMAIN="$i"
  DOMAIN_SUBST="${DOMAIN//'*.'}"
  create_or_renew
done
if $RENEW; then
  renew_cert
fi

