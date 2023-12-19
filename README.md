# Docker-taky

Docker wrapper for taky - A simple COT server for ATAK \
https://github.com/tkuester/taky

# Requirements
Docker must be installed
Only tested on Debian Bookworm, but should work on most Linux operating systems 

# Install / build - docker
```shell
# Default user and group id - 1000
$ docker build --tag taky .

# Change user or group id 
$ docker build --build-arg 'PGID=1005' --build-arg 'PUID=1005' -t taky .
$ docker run taky id
uid=1005(taky) gid=1005(taky) groups=1005(taky)
```

## Usage
```shell
$ docker run taky takyctl -h
usage: takyctl [-h] [-c CFG_FILE] [--version]
               {setup,build_client,systemd,status,kickban} ...

Taky command line utility

positional arguments:
  {setup,build_client,systemd,status,kickban}
    setup               Setup the taky server
    build_client        Build client file
    systemd             Generate systemd service scripts
    status              Check the status of the taky server
    kickban             Kick and banish a user

options:
  -h, --help            show this help message and exit
  -c CFG_FILE           Path to configuration file
  --version             show program´s version number and exit
```

# Install / build - docker-compose
```shell
# Default user and group id - 1000
$ docker-compose up -d

# Change user or group id 
$ docker-compose build --build-arg 'PGID=1005' --build-arg 'PUID=1005'
$ docker-compose up -d
# OR edit arg in docker-compose.yaml
```
