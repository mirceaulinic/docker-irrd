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

Or a specific version, e.g., ``4.2.8``:

.. code-block:: bash

  $ docker pull mirceaulinic/irrd:4.2.8

.. note::

    The image doesn't include the database service; for that, you'll need to 
    run an external service, or container.

    It does however provide the packages to access the database referenced in 
    the ``database_url`` in the IRRd configuration file, and ``gnupg`` for the 
    authentication keyring.

In order to provide it with your own IRRd configuration, you can mount that as 
a volume to the Docker container, e.g.,

.. code-block:: bash

    $ docker run --rm -d -v /path/to/my/irrd.yaml:/etc/irrd.yaml mirceaulinic/irrd:4.2.8

In a similar way you can provide the GnuPG keyring.

Docker Compose
--------------

This repo provides a docker-compose file. For this, you need to have 
docker-compose installed, see the `installation notes 
<https://github.com/docker/compose#where-to-get-docker-compose>`__.

Once docker-compose is available on your machine, you can go ahead and run 
``make start`` in order to get the environment up and running. It takes 
a couple of minutes to start the service and load the data, but once you see 
the following lines in the output, it should be ready:

.. code-block:: text

  irrd        | 2023-06-05 10:21:18,474 irrd[49]: [uvicorn.error#INFO] Started server process [49]
  irrd        | 2023-06-05 10:21:18,475 irrd[49]: [uvicorn.error#INFO] Waiting for application startup.
  irrd        | 2023-06-05 10:21:18,542 irrd[40]: [uvicorn.error#INFO] Started server process [40]
  irrd        | 2023-06-05 10:21:18,549 irrd[40]: [uvicorn.error#INFO] Waiting for application startup.
  irrd        | 2023-06-05 10:21:18,571 irrd[49]: [uvicorn.error#INFO] Application startup complete.
  irrd        | 2023-06-05 10:21:18,642 irrd[40]: [uvicorn.error#INFO] Application startup complete.
  irrd        | 2023-06-05 10:21:18,701 irrd[47]: [uvicorn.error#INFO] Started server process [47]
  irrd        | 2023-06-05 10:21:18,701 irrd[47]: [uvicorn.error#INFO] Waiting for application startup.
  irrd        | 2023-06-05 10:21:18,733 irrd[37]: [uvicorn.error#INFO] Started server process [37]
  irrd        | 2023-06-05 10:21:18,733 irrd[37]: [uvicorn.error#INFO] Waiting for application startup.
  irrd        | 2023-06-05 10:21:18,774 irrd[47]: [uvicorn.error#INFO] Application startup complete.
  irrd        | 2023-06-05 10:21:18,807 irrd[37]: [uvicorn.error#INFO] Application startup complete.

You can now run queries against your local IRRd server, e.g.,

.. code-block:: bash

  $ whois -h localhost -p 8043 190.93.240.0/20
  route:          190.93.240.0/20
  descr:          Cloudflare, Inc.
  origin:         AS13335
  mnt-by:         MAINT-CLOUDFLARE
  changed:        martin@cloudflare.com 20200616
  source:         ALTDB

As per above, the local port is mapped (in the docker-compose file) to 8043, 
but this can be easily changed if you have a different preference.

.. important::

  In this repo, I have provided an SQL dump corresponding to the IRR data from
  ALTDB. This source was selected purely because it's one of the smallest data 
  sources available publicly.

  If you prefer a different (or multiple sources), you can edit the
  ``irrd.yaml`` file in this repository, then IRRd will gather the data from
  there. Keep in mind however that the more sources you have (and
  the larger they are -- RADd, ARIN, RIPE, etc. are typically much larger than 
  ALTDB), the longer it'll take to download that information and load it into 
  the local database.

  If you decide to adjust the ``sources`` section in the ``irrd.yaml`` file, it
  might be a good idea to dump the database in order to save time when you 
  start the local IRRd service next time. For this scope, you can run ``make 
  dump``.
