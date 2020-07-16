Docker image for IRRd
=====================

|Docker pulls|

.. |Docker pulls| image:: https://img.shields.io/docker/pulls/mirceaulinic/irrd.svg
   :target: https://hub.docker.com/r/mirceaulinic/irrd

Docker files for `IRRd <https://github.com/irrdnet/irrd>`__. The Docker image is
available on Docker hub at 
https://hub.docker.com/repository/docker/mirceaulinic/irrd and therefore can be 
pulled as:

.. code-block:: bash

  $ docker pull mirceaulinic/irrd

Or a specific version, e.g., ``4.0.8``:

.. code-block:: bash

  $ docker pull mirceaulinic/irrd:4.0.8

.. note::

    The image doesn't include the database service; for that, you'll need to 
    run an external service, or container.

    It does however provide the packages to access the database referenced in 
    the ``database_url`` in the IRRd configuration file, and ``gnupg`` for the 
    authentication keyring.

In order to provide it with your own IRRd configuration, you can mount that as 
a volume to the Docker container, e.g.,

.. code-block:: bash

    $ docker run --rm -d -v /path/to/my/irrd.yaml:/etc/irrd.yaml mirceaulinic/irrd:4.0.8

In a similar way you can provide the GnuPG keyring.
