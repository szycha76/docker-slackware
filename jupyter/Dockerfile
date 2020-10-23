FROM szycha/slackware-python:current

RUN yes | slackpkg update; yes | slackpkg upgrade-all
RUN yes | slackpkg install icu4c libedit sqlite
RUN pip install jupyterlab

COPY .buildtag /

EXPOSE 8888/tcp
ENTRYPOINT ["/usr/bin/jupyter-lab"]
CMD ["--allow-root"]
