# Hacker House Hacklab 
# ====================
# a minimal bleeding-edge hacklab docker container
# contains a subset of popular auditing and reverse
# engineering tools.
#
# VERSION 0.4
FROM scratch
MAINTAINER Hacker House

ADD http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64/stage3-x32-20181016T214502Z.tar.xz /

ENV LANG en_US.UTF-8

RUN \
	# system configuration
	emerge-webrsync && \
	locale-gen && \
	# add ruby 2.3 for msf & python sqlite for nmap
	echo ACCEPT_KEYWORDS=\"~amd64\" >> /etc/portage/make.conf && \
	mkdir /etc/portage/profile && \
	echo "-ruby_targets_ruby23" >> /etc/portage/profile/use.stable.mask && \
	echo "-ruby_targets_ruby25" >> /etc/portage/profile/use.stable.mask && \
	echo RUBY_TARGETS=\"ruby22 ruby23 ruby24 ruby25\" >> /etc/portage/make.conf && \
	echo "dev-lang/python sqlite" >> /etc/portage/package.use/python && \
	emerge dev-lang/python:2.7 && \
	eselect python set 2 && \
	USE=ruby_targets_24 emerge ruby && \
	eselect ruby set ruby23 && \
	emerge --update --deep --newuse @world && \
	# add base system tools
	emerge dev-libs/libpqxx net-misc/curl gdb dev-vcs/git app-portage/gentoolkit \
	app-editors/vim net-analyzer/openbsd-netcat net-analyzer/tcpdump net-analyzer/hping \
	net-analyzer/fping net-analyzer/nbtscan net-analyzer/dsniff app-admin/sudo && \
	# add security tools
	echo "%wheel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
        echo "net-analyzer/nmap ncat ndiff nping" >> /etc/portage/package.use/nmap && \
        echo "net-analyzer/hydra mysql subversion" >> /etc/portage/package.use/hydra && \
	emerge nmap hydra && \
	# add radare2 and upx packer tool
	emerge upx-bin radare2 && \
	emerge strace ltrace && \
	# build metasploit git
	ldconfig && \
	source /etc/profile && \
	gem install bundler && \
	useradd -m -g wheel user && \
	su - user -c "git clone https://github.com/rapid7/metasploit-framework" && \
	su - user -c "cd ~/metasploit-framework && bundle install" && \
	# build and deploy elfsh
	su - user -c "cd ~ && git clone https://github.com/thorkill/eresi" && \
	su - user -c "cd ~/eresi && ./configure --enable-32-64 && make" && \
	cd /home/user/eresi && \
	make install
USER user
CMD ["/bin/bash", "-i"]
