## Docker container with Debian SDK
 
 This is a docker implementation of all required tools to build eisfair-ng 
 packages for Debian.

 For more information please refer to [Official website](http://www.eisfair.org/) 
 or [Support forum](https://forum.nettworks.org)

### 1. Install docker

 For installation please see [official documentation](https://docs.docker.com/install/linux/docker-ce/debian/).

### 2. Build/Use the Container

You now have two options: 
- Build from scratch or 
- Pull the ready-made image from DockerHub. 

#### 2a Image from Docker Hub

```shell
sudo docker pull nettworksevtooling/eisfair-ng-buildcontainer
```

#### 2b Build from scratch

##### Pull repo from github

```shell
sudo git clone https://github.com/nettworks-e-V/eisfair-ng-buildcontainer
cd eisfair-ng-buildcontainer
```

##### Build image

```shell
sudo docker build -t nettworksevtooling/eisfair-ng-buildcontainer:latest .
```

### 3. Starting docker container

```shell
sudo docker run \
    --name eisfair-ng-buildcontainer \
    -d \
    nettworksevtooling/eisfair-ng-buildcontainer:latest
```

#### 3.a Mount volume or folder for svn checkout

With the additional run parameter _-v <host-folder>:/data/work/_ you can mount 
a folder on the docker host which contains the Git clone outside of the
container. So the run command may look like the following example:

```shell
sudo docker run \
    --name eisfair-ng-buildcontainer \
    -v /data/git-clone/:/data/work/ ...
```

### 5. Useful commands

Check running / stopped container:

```shell
sudo docker ps -a
```

Stop the container

```shell
sudo docker stop eisfair-ng-buildcontainer
```

Start the container

```shell
sudo docker start eisfair-ng-buildcontainer
```

Get logs from container

```shell
sudo docker logs -f eisfair-ng-buildcontainer
```

Open cmdline inside of container

```shell
sudo docker exec -i -t eisfair-ng-buildcontainer /bin/bash
```
