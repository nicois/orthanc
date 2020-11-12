FROM osimis/orthanc:master
RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get --assume-yes update && \
  apt-get --assume-yes install postgresql-client cmake mercurial unzip && \
  apt-get --assume-yes clean && \
  rm --recursive --force /var/lib/apt/lists/*
RUN apt-get update
RUN mkdir /build/
WORKDIR /build
RUN hg clone https://hg.orthanc-server.com/orthanc/
RUN mkdir /build/orthanc/Build
WORKDIR /build/orthanc/Build
RUN cmake -DSTATIC_BUILD=ON -DCMAKE_BUILD_TYPE=Debug ../OrthancServer/
RUN make
RUN mv /build/orthanc/Build/Orthanc /usr/local/bin/
RUN rm -rf /build/
COPY docker-entrypoint.sh /
