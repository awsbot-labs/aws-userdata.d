#!/bin/bash -x
# -x expand for troubleshooting
# Monitoring Client
# Install the sensu core so that the client can be used.
cat <<EOF > /etc/yum.repos.d/sensu.repo
[sensu]
name=sensu
baseurl=http://repositories.sensuapp.org/yum/x86_64/
gpgcheck=0
enabled=1
EOF
yum update -y
yum install -y sensu
chkconfig sensu-client on
cat <<EOF > /etc/sensu/conf.d/client.json
{
  "client": {
    "name": "$(hostname)",
    "metric_prefix": "$(hostname)",
    "address": "127.0.0.1",
    "socket": {
      "bind": "0.0.0.0"
    },
    "subscriptions": [ "all" ]
  }
}
EOF
cat <<EOF > /etc/sensu/config.json
{
  "rabbitmq": {
    "host": "rabbitmq",
    "vhost": "/sensu",
    "user": "sensu",
    "password": "sensu"
  }
}
EOF
chown -R sensu:sensu /etc/sensu
service sensu-client start

