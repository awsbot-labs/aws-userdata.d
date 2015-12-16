#!/bin/bash -x
# -x expand for troubleshooting
# Amazon API and vim editor
# Install Prerequisites
yum install -y awslogs

cat <<EOF > /etc/awslogs/awscli.conf
[plugins]
cwlogs = cwlogs
[default]
region = eu-west-1
EOF

cat <<EOF > /etc/awslogs/awslogs.conf
[general]
state_file = /var/lib/awslogs/agent-state
[/var/log/messages]
datetime_format = %b %d %H:%M:%S
file = /var/log/messages
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/messages
[/var/log/secure]
datetime_format = %b %d %H:%M:%S
file = /var/log/secure
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/secure
[/var/log/sensu/sensu-client.log]
datetime_format = %b %d %H:%M:%S
file = /var/log/sensu/sensu-client.log
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/sensu/sensu-client.log
[/var/log/cloud-init-output.log]
datetime_format = %b %d %H:%M:%S
file = /var/log/cloud-init-output.log
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/cloud-init-output.log
[/var/log/cloud-init-output.log]
datetime_format = %b %d %H:%M:%S
file = /var/log/cloud-init.log
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/cloud-init.log
EOF
chkconfig awslogs on
service awslogs start
