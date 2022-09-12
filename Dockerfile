# https://docs.docker.com/develop/develop-images/multistage-build/
FROM ubuntu AS builder

ARG MKGMAP_VERSION=r4905
ARG SPLITTER_VERSION=r652
ARG OSMOSIS_VERSION=0.48.3

WORKDIR /build
RUN apt-get update && apt-get install -y wget unzip \
  && wget http://www.mkgmap.org.uk/download/mkgmap-$MKGMAP_VERSION.zip \
  && unzip mkgmap-$MKGMAP_VERSION.zip \
  && mv mkgmap-$MKGMAP_VERSION mkgmap \
  && wget http://www.mkgmap.org.uk/download/splitter-$SPLITTER_VERSION.zip \
  && unzip splitter-$SPLITTER_VERSION.zip \
  && mv splitter-$SPLITTER_VERSION splitter \
  && wget https://github.com/openstreetmap/osmosis/releases/download/$OSMOSIS_VERSION/osmosis-$OSMOSIS_VERSION.zip \
  && (mkdir -p osmosis && cd osmosis && unzip ../osmosis-0.48.3.zip) \
  && wget http://osm.thkukuk.de/data/sea-latest.zip


#FROM openjdk:11-jre-slim
FROM amazoncorretto:18
COPY --from=builder /build/mkgmap /mkgmap
COPY --from=builder /build/splitter /splitter
COPY --from=builder /build/osmosis /osmosis
COPY --from=builder /build/sea-latest.zip /
COPY garmin/ /garmin
RUN echo 'alias ll="ls -lah --color"' >> /root/.bashrc

ADD process.sh /process.sh
VOLUME /data

CMD /process.sh
