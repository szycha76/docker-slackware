FROM szycha/slackware:current

RUN yes | slackpkg update; yes | slackpkg upgrade-all

RUN yes | slackpkg install curl nghttp2
RUN yes | slackpkg install brotli cyrus-sasl zstd
RUN yes | slackpkg install cpio

COPY .buildtag /
