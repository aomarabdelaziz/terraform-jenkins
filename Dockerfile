FROM jenkins/jenkins:lts

USER root

# Install Docker CLI (only CLI needed, daemon is on host)
RUN apt-get update && \
    apt-get install -y docker.io && \
    rm -rf /var/lib/apt/lists/*


ARG DOCKER_GID_ARG
ENV DOCKER_GID=${DOCKER_GID_ARG}


RUN groupdel docker || true && \
groupadd -g $DOCKER_GID docker && \
usermod -aG docker jenkins


USER jenkins



docker build --build-arg DOCKER_GID_ARG=$(getent group docker | cut -d: -f3) -t jenkins:dnd .


docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins:dnd
