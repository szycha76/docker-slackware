FROM vbatts/slackware:current

# Image build leftovers and misses
RUN rm /README; mv /.bashrc /root/

# Update everything (potentially harmful)
RUN yes | slackpkg update; yes | slackpkg upgrade-all

# Missing dependencies as of X.2020
RUN yes | slackpkg install libmnl pam-1 libcap-ng iptables libpcap dbus-1 \
	libnl3 libnfnetlink libnftnl libnetfilter_conntrack

# PAM dependencies
RUN yes | slackpkg install gnome-keyring libpwquality cracklib libtirpc \
	e2fsprogs # SIC(!)
