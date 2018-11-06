ARG UBUNTU_RELEASE=bionic

FROM ubuntu:${UBUNTU_RELEASE}

ARG UBUNTU_RELEASE

ENV UBUNTU_RELEASE=${UBUNTU_RELEASE}

# TODO: user name should be customisable?
RUN apt-get update && \
	apt-get install sudo -y && \
	adduser --disabled-password --gecos '' dev && \
	adduser dev sudo && \
	echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists

# Required for `clear` command to work, etc.
ENV TERM screen-256color

ENV DOCKER_CLI_SHA256 "7ceb584cedba158b335fa2df11556cd70c6c528c7c93ceb3bf9aa13903e824cd"
ENV DOCKER_CLI_VERSION "18.06.0"

COPY build.sh /tmp/build.sh

RUN bash /tmp/build.sh && \
	rm /tmp/build.sh

# For some reason, this environment variable isn't set by docker.
ENV USER dev

ENV HOME /home/dev

WORKDIR /home/dev

USER dev

COPY ./inputrc "$HOME/.inputrc"

RUN sudo chown "$USER":"$USER" "$HOME/.inputrc"

CMD ["/bin/bash"]
