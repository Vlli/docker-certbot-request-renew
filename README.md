# docker-certbot-request-renew
This project creates an docker image which request or renew a certificate whether it exist or not.

# Usage:
To obtain a certificate you have to run the Image with following parameters:

docker run -e DOMAINS="example.com" -e MAIL=admin@example.com vlli/docker-certbot-request-renew:route53

At the current situation you must use an IAM Role for your EC2 Instance which have the permission to create DNS entries.

# Wildcard Certificates
Every certificate which is obtained by the script will also be a wildcard certificate. This behaviour is not optional.