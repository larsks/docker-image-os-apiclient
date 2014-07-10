Keystone client
==============

This image contains the `keystone` command line client and is meant to
interact with my [larsks/keystone][] container.

[larsks/keystone]: https://registry.hub.docker.com/u/larsks/keystone/

If you have the `larsks/keystone` image running in a container named
`keystone`, the following will populate the keystone service and
endpoint entries and then create an `admin` user:

     $ docker run --rm -it --link keystone:keystone \
      larsks/keystoneclient sh /root/setup-keystone.sh
    ======================================================================
    Initializing keystone
    ======================================================================

    Creating keystone service.
    Creating keystone endpoint.
    Creating admin tenant.
    Creating admin role.
    Creating admin user.
    Assigning admin user to admin role.

    All done.
    ======================================================================

