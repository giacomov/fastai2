FROM nvidia/cuda:10.2-base

# Copy code from repo to container
RUN mkdir /root/fastai2
COPY . /root/fastai2

# Copy installer from repo to container
COPY ./docker/install_within_container.sh /root/install_within_container.sh

# Run installer
RUN cd /root && chmod u+x install_within_container.sh && ./install_within_container.sh && rm -rf install_within_container.sh

# Overide user name at build, if buil-arg no passed, will create user named `default` user
ARG DOCKER_USER=fastai2

# Create a group and user
RUN useradd -ms /bin/bash $DOCKER_USER

# Assign the conda directory to that user
RUN chown --recursive $DOCKER_USER:$DOCKER_USER /miniconda3

# Tell docker that all future commands should run as the non-root user
USER $DOCKER_USER

# Copy entrypoing
COPY --chown=$DOCKER_USER ./docker/entrypoint.sh /home/fastai2/entrypoint.sh
RUN chmod u+x /home/fastai2/entrypoint.sh

WORKDIR /home/fastai2

ENTRYPOINT ["/bin/bash", "/home/fastai2/entrypoint.sh"]

CMD ["jupyter", "lab", "--no-browser"]
