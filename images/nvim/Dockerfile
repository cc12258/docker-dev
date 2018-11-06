ARG BASE_TAG=latest

FROM cc121/power-tmux:$BASE_TAG

USER dev

COPY ./build.sh /tmp/build.sh

COPY ./bashrc-additions.sh /tmp/bashrc-additions.sh

COPY init.vim "$HOME/.config/nvim/init.vim"
COPY plugin.vim "$HOME/.config/nvim/plugin.vim"
COPY post-plugin.vim "$HOME/.config/nvim/post-plugin.vim"

COPY ./ycm-install /usr/local/bin/ycm-install

RUN /tmp/build.sh && \
	sudo rm /tmp/build.sh

CMD ["bin/bash"]

