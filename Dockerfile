FROM fedora:33 AS build
RUN cd /tmp \
    && curl -L https://github.com/bats-core/bats-core/archive/v1.3.0.tar.gz | tar xzf - \
    && cd bats-core-1.3.0 \
    && ./install.sh PKG/usr

FROM fedora:33
MAINTAINER horky@d3s.mff.cuni.cz
LABEL maintainer="horky@d3s.mff.cuni.cz"

# Things that are installed:
#  - vim and mc for debugging and interactive sessions
#  - Python and related utilities
#  - system tools
#  - developer tools
RUN dnf install -y mc vim \
    && dnf install -y python3 python3-pip pylint python3-virtualenv \
    && dnf install -y git ShellCheck jq make pandoc bc findutils wget diffutils \
    && dnf clean all
COPY --from=build /tmp/bats-core-1.3.0/PKG /

CMD echo "Run with -it /bin/bash and proper volume mounted"
