# xTeVe
[![Build Status](https://cloud.drone.io/api/badges/LANsible/docker-xteve/status.svg)](https://cloud.drone.io/LANsible/docker-xteve)
[![Docker Pulls](https://img.shields.io/docker/pulls/lansible/xteve.svg)](https://hub.docker.com/r/lansible/xteve)
[![Docker Version](https://images.microbadger.com/badges/version/lansible/xteve:latest.svg)](https://microbadger.com/images/lansible/xteve:latest)
[![Docker Size/Layers](https://images.microbadger.com/badges/image/lansible/xteve:latest.svg)](https://microbadger.com/images/lansible/xteve:latest)

## Why not use the official container?

It does not work on Kubernetes with a configmap since it tries to create the settings.json etc in the directory where the config is mounted.
This container allows this setup to work flawlessly!

## Test container with docker-compose

```
cd examples/compose
docker-compose up
```

### Building the container locally

You could build the container locally to add plugins. It works like this:

```bash
docker build . \
      --build-arg VERSION=2.1.0 \
      --tag lansible/xteve:2.1.0
```
The arguments are:

| Build argument | Description                                    | Example                 |
|----------------|------------------------------------------------|-------------------------|
| `VERSION`      | Version of xteve                               | `2.1.0`                 |

## Credits

* [xteve-project/xTeVe](https://github.com/xteve-project/xTeVe)
