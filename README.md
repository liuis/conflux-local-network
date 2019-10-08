# conflux-local-network
Docker-compose based configuration to easily run locally deployed dev/test network

To start the network:

```bash
docker-compose up -d
```

To destroy the network:

```bash
docker-compose down
```

To cleanup the associated docker volumes, `-v` option could be used:

```bash
docker-compose down -v
```

More details can be found in [`docker-compose` documentation](https://docs.docker.com/compose/reference/).

### Single Node Configuraiton

To use a Single Node Configuration just append `-f singlenode.yml` to the docker-compose command. Example:

```bash
docker-compose -f singlenode.yml up
```

