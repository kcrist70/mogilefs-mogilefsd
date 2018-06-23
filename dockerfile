FROM perl:latest
MAINTAINER	kcrist
WORKDIR /etc/mogilefs/
ADD . /etc/mogilefs/
RUN cpanm MogileFS::Server \
    && cpanm MogileFS::Utils \
    && cpanm MogileFS::Client \
    && cpanm IO::AIO \
    && cpanm DBD::mysql \
    && cpanm  DBD::mysql \
    && groupadd -r mogile \
    && useradd -r -g mogile mogile \
    && chown -R mogile.mogile /etc/mogilefs/
EXPOSE	7001
USER mogile:mogile
CMD ["mogilefsd","-c","/etc/mogilefs/mogilefsd.conf"]
