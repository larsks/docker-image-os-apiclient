#!/bin/sh

logfile=/var/log/setup-nova

. /root/keystonerc

cat <<EOF
======================================================================
Setting up nova in keystone
======================================================================

EOF

sh /root/add-keystone-service.sh \
	nova compute 'http://nova:8774/v2/%(tenant_id)s'

echo "Creating nova user."
keystone user-create --name nova --tenant services --pass secret >>$logfile

echo "Assigning nova user to admin role."
keystone user-role-add --user nova --role admin --tenant services >>$logfile
keystone user-role-remove --user nova --role _member_ --tenant services >>$logfile

cat <<EOF

All done.
======================================================================
EOF

