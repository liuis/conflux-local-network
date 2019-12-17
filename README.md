# warning
this repo run the conflux-chain node is the *test-mode*, just for test/dev environment, don't use this for the fromal online environment.


# conflux-local-network
Docker-compose based configuration to easily run locally deployed dev/test network


if you don't use docker-compose, just docker && if you want build by yourself , just run:

```bash
docker build -t conflux-chain:v0.1.10 .

```
# USE:

```bash
docker pull liqiazero/conflux-chain:v0.1.10


docker run --name conflux-chain  -p 12537:12537 -p 32323:32323 -p 32323:32323/udp -p 14629:14629 -p 12539:12539  -d liqiazero/conflux-chain:v0.1.10

```

if u want use docker-compose, just following:

# docker-compose

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

