# docker-rpi-dozzle

Dozzle is a real-time log viewer for Docker. It's free. It's small.
And it's right in your browser.

Have a look: https://dozzle.dev/


### Develop and test builds

Just type:

```
docker build . -t dozzle
```

### Create final release and publish to Docker Hub

```
create-release.sh
```


### Run

Given the docker image with name `dozzle`:

```
docker run --name logging -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -d jriguera/dozzle
```

If you get an error like `FATAL Could not connect to Docker Engine: Error response from daemon: client version 1.41 is too new. Maximum supported API version is 1.40`,
run `docker version` to check the Docker engine version and you can try:

```
# Force a docker version using the binary
export DOCKER_API_VERSION=1.40
# and in Docker, run it passing the version
docker run --name logging -p 8080:8080 -e DOCKER_API_VERSION=1.40 -v /var/run/docker.sock:/var/run/docker.sock -d jriguera/dozzle

```


# Author

Jose Riguera `<jriguera@gmail.com>`
