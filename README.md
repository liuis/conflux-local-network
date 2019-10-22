# conflux-local-network
Docker-compose based configuration to easily run locally deployed dev/test network


if you don't use docker-compose, just docker run:

```bash
docker build -t conflux-chain:v1 .

```

```bash
docker run --name node1 -p 12537:12537 -d conflux-chain:v1
```

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

