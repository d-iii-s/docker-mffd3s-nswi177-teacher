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
    && dnf install -y git ShellCheck jq yajl make pandoc bc findutils wget diffutils file \
    && dnf install -y perl-Image-ExifTool poppler-utils ImageMagick \
    && dnf install -y ruby rubygem-bundler \
    && dnf clean all
    && mkdir -p /srv/nswi177/ \
    && curl --silent https://raw.githubusercontent.com/d-iii-s/docker-mffd3s-nswi177-base/main/machines.status >/srv/nswi177/machine.status \
    && curl --silent https://raw.githubusercontent.com/d-iii-s/docker-mffd3s-nswi177-base/main/hurricane.jpg >/srv/nswi177/hurricane.jpg \
    && curl --silent https://raw.githubusercontent.com/d-iii-s/docker-mffd3s-nswi177-base/main/flanders.pdf >/srv/nswi177/flanders.pdf \
    && curl --silent https://raw.githubusercontent.com/lavakin/lavakin.github.io/main/pdfs/fasta.fa >/srv/nswi177/arabidopsis.fasta
COPY --from=build /tmp/bats-core-1.3.0/PKG /

CMD echo "Run with -it /bin/bash and proper volume mounted"
