FROM fedora:34 AS build
RUN cd /tmp \
    && curl -L https://github.com/bats-core/bats-core/archive/v1.3.0.tar.gz | tar xzf - \
    && cd bats-core-1.3.0 \
    && ./install.sh PKG/usr

FROM mffd3s/nswi177-common:latest
MAINTAINER horky@d3s.mff.cuni.cz
LABEL maintainer="horky@d3s.mff.cuni.cz"

# Install BATS and interactive utilities
RUN dnf install -y mc vim && dnf clean all
COPY --from=build /tmp/bats-core-1.3.0/PKG /

CMD echo "Run with -it /bin/bash and proper volume mounted"
