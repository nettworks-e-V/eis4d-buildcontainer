## Docker container with eisfair-ng SDK
 
 This is a docker implementation of all required tools to build eisfair-ng 
 packages.

 For more information please refer to [Official website](http://www.fli4l.de/) 
 or [Support forum](https://forum.nettworks.org)

### 1. Install docker

 This instruction works for a <b>Centos7</b> docker host. Other distributions 
 may need some adjustments.

```shell
sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
...
sudo yum install docker-engine -y
...
sudo systemctl enable docker.service
...
sudo systemctl start docker.service
```

### 2. Build/Use the Container

You now have two options: 
- Build from scratch or 
- Pull the ready-made image from DockerHub. 

#### 2a Image from Docker Hub

```shell
sudo docker pull starwarsfan/eisfair-ng-buildcontainer
```

#### 2b Build from scratch

##### Pull repo from github

```shell
sudo git clone https://github.com/starwarsfan/eisfair-ng-buildcontainer.git
cd eisfair-ng-buildcontainer
```

##### Build image

```shell
sudo docker build -t starwarsfan/eisfair-ng-buildcontainer:latest .
```

### 3. Starting docker container

```shell
sudo docker run \
    --name eisfair-ng-buildcontainer \
    -d \
    starwarsfan/eisfair-ng-buildcontainer:latest
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
