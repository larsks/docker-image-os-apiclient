#!/bin/sh

logfile=/var/log/setup-keystone.log

_keystone () {
	keystone --os-endpoint http://keystone:35357/v2.0 --os-token ADMIN "$@"
}

cat <<EOF
======================================================================
Initializing keystone
======================================================================

EOF

echo "Creating keystone service."
_keystone service-create --name keystone --type identity | tee /tmp/keystone.service >>$logfile
svcid=$(awk '$2 == "id" {print $4}' /tmp/keystone.service)

echo "Creating keystone endpoint."
_keystone endpoint-create --service $svcid \
	--publicurl http://keystone:5000/v2.0 \
	--adminurl http://keystone:35357/v2.0 \
	--internalurl http://keystone:5000/v2.0 >>$logfile

echo "Creating admin tenant."
_keystone tenant-create --name admin >>$logfile

echo "Creating admin role."
_keystone role-create --name admin >>$logfile

echo "Creating admin user."
_keystone user-create --name admin --tenant admin --pass secret >>$logfile

echo "Assigning admin user to admin role."
_keystone user-role-add --user admin --role admin --tenant admin >>$logfile

echo "Creating services tenant."
_keystone tenant-create --name services >> $logfile

cat <<EOF

All done.
======================================================================
EOF

