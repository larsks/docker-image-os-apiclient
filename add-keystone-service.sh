#!/bin/sh

# usage: add-keystone-service -i <internalurl> -a <adminurl> <name> <type> <puburl>

while getopts i:a: ch; do
	case $ch in
	(i) svc_internalurl="$OPTARG";;
	(a) svc_adminurl="$OPTARG";;
	esac
done
shift $(( $OPTIND - 1 ))

svc_name=$1
svc_type=$2
svc_publicurl=$3
: ${svc_internalurl:=$svc_publicurl}
: ${svc_adminurl:=$svc_publicurl}

echo "Removing existing $svc_name services and endpoints"
keystone service-list | awk -vname=$svc_name '$4 == name {print $2}' |
while read svcid; do
	echo "  service id: $svcid"
	keystone endpoint-list | awk -vsvcid=$svcid '$12 == svcid {print $2}' |
	while read endpointid; do
		echo "    endpoint id: $endpointid"
		keystone endpoint-delete $endpointid > /dev/null
	done
	keystone service-delete $svcid
done

echo -n "Creating new service entry for $svc_name: "
svcid=$(keystone service-create --name $svc_name --type $svc_type |
	awk '$2 == "id" {print $4}')
echo $svcid

echo -n "Creating new endpoint entry for $svc_name: "
endpointid=$(keystone endpoint-create --service $svcid \
	--publicurl "$svc_publicurl" \
	--internalurl "$svc_internalurl" \
	--adminurl "$svc_adminurl" | 
	awk '$2 == "id" {print $4}')
echo $endpointid


