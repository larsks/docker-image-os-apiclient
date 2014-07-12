OpenStack API Client
====================

This image contains various OpenStack command line client tools.  It
is meant to interact with my OpenStack service images:

- [Keystone][]
- [Glance][]
- [Nova controller][]

[keystone]: https://registry.hub.docker.com/u/larsks/keystone/
[glance]: https://registry.hub.docker.com/u/larsks/glance/
[nova controller]: https://registry.hub.docker.com/u/larsks/nova-controller/

You will generally want to use Docker's `--link` option to link this
container to the other services containers.  A typical run would look
like:

    docker run --rm \
      --link keystone:keystone \
      --link glance:glance \
      --link nova:nova \
      --volumes-from nova \
      --volumes-from keystone \
      --volumes-from glance \
      --volumes-from rabbitmq \
      -it \
      larsks/os-apiclient

The `--volumes-from` argument are not necessary, but they make it
possible to access logs and databases from within the client.

Convenient scripts
==================

The `start-openstack-cluster` script, in this repository, will start
all the service containers.

The `start-openstack-client` script will run the client as described
above.


