ARG AM_VERSION="am-12.2"
ARG AM_MD5="2f76efc600ab087ef0f124b06258e758"

FROM gcc:12-bullseye AS build

ARG AM_VERSION
ARG AM_MD5

WORKDIR /tmp

RUN curl --location --show-error --silent --output ${AM_VERSION}.tgz https://zenodo.org/record/6774378/files/${AM_VERSION}.tgz?download=1 \
&& echo "${AM_MD5} ${AM_VERSION}.tgz" | md5sum --check \
&& tar -xzf ${AM_VERSION}.tgz \
&& cd ${AM_VERSION}/src \
&& make gcc-omp 'EXTRA_CFLAGS = -static' \
&& make install


FROM debian:bullseye-slim AS runtime
COPY --from=build /usr/local/bin/am /usr/local/bin/am
RUN apt update && apt install libgomp1 -y --no-install-recommends \
&& apt clean \
&& rm -rf /var/lib/apt/lists/* \
&& mkdir ~/.am

ENV AM_CAHCE_PATH=~/.am

ENTRYPOINT ["/usr/local/bin/am"]

LABEL org.opencontainers.image.source=https://lweb.cfa.harvard.edu/~spaine/am/download/src/
LABEL org.opencontainers.image.version=${AM_VERSION}
