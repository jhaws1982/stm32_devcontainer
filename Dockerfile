# Debian development container
ARG VARIANT=ubuntu24.04
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

# Install typical build tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    echo "Acquire::Retries \"3\";" > /etc/apt/apt.conf.d/90retry && \
    apt-get -y remove build-essential && \
    apt-get -y autoremove && \
    apt-get -y install --no-install-recommends \
    git gcovr googletest google-mock clang-format npm \
    p7zip-full curl jq
RUN  npm install -g release-it @release-it/conventional-changelog @j-ulrich/release-it-regex-bumper --save-dev

# Install STM32CubeCLT
# Latest DEB download at https://www.st.com/en/development-tools/stm32cubeclt.html
# Extract *.zip to get the *.sh file and update the filename here
ENV CLT_SCRIPT "st-stm32cubeclt_1.19.0_25876_20250729_1159_amd64.deb_bundle.sh"
COPY ${CLT_SCRIPT} /tmp/CLT.sh
RUN cd /tmp && chmod a+x CLT.sh && \
    echo /opt/st/stm32cubeclt_ | LICENSE_ALREADY_ACCEPTED=1 ./CLT.sh --nox11 && \
    rm CLT.sh

# Setup some handy aliases
RUN echo "alias ll='ls -lA'" >> /home/vscode/.bash_aliases && \
    echo "alias lh='ls -lAh'" >> /home/vscode/.bash_aliases && \
    echo "alias vim=vi" >> /home/vscode/.bash_aliases && \
    chown vscode:vscode /home/vscode/.bash_aliases

ENTRYPOINT ["/usr/local/share/docker-init.sh"]
CMD ["sleep", "infinity"]
