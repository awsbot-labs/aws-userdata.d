#!/bin/bash -x
# -x expand for troubleshooting
# Configuration Management (Salt Minion in this case)
# Install the salt-minion for configuration management
wget https://repo.saltstack.com/yum/rhel6/SALTSTACK-GPG-KEY.pub
rpm --import SALTSTACK-GPG-KEY.pub
rm -f SALTSTACK-GPG-KEY.pub
cat <<EOF > /etc/yum.repos.d/saltstack.repo
####################
# Enable SaltStack's package repository
[saltstack-repo]
name=SaltStack repo for RHEL/CentOS 6
baseurl=https://repo.saltstack.com/yum/rhel6
enabled=1
gpgcheck=1
gpgkey=https://repo.saltstack.com/yum/rhel6/SALTSTACK-GPG-KEY.pub
EOF
yum clean expire-cache
yum update -y
yum install -y salt-minion
# Disable Masterless salt-minions
# https://docs.saltstack.com/en/latest/topics/tutorials/quickstart.html
chkconfig salt-minion off
service salt-minion stop
cat <<EOF > /etc/salt/minion
file_client: local
EOF

cat <<EOF > /etc/cron.d/salt-call
MAILTO=""
*/15 * * * * root salt-call --local state.highstate
EOF
