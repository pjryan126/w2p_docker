# Web2py Dockerfile
###### Run [web2py](www.web2py.com) with gunicorn as a [Docker](www.docker.com) container.

### Summary
This is a Dockerfile that builds an image based on ubuntu for running web2py with gunicorn as a Docker container. The file is inspired by O.S. Tezer's [tutorial](https://www.digitalocean.com/community/tutorials/docker-explained-how-to-containerize-python-web-applications) on containerizing Python web apps on the [DigitalOcean](www.digitalocean.com) community site.

### How it works

1. [Install](https://docs.docker.com/installation) and run Docker.

2. Once you are up and running with Docker, copy the Dockerfile to the root directory of your project and run Docker build:
> ```sudo docker build -t [image name]```

3. Run a container based on your newly created image
> ```sudo docker run --name [container name] -p [host port]:[docker port] -i -t [image name]```

