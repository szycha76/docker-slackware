FROM szycha/slackware:current

RUN yes | slackpkg update; yes | slackpkg upgrade-all

# I like VIm.  Install VIm!
RUN yes | slackpkg install vim-8 perl-5

# Install Python3 and pip:
RUN yes | slackpkg install python3 python-pip python-urllib3 python-setuptools

COPY .buildtag /
