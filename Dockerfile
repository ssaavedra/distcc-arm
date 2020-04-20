FROM archlinux:latest

RUN pacman -Syu --noconfirm && \
	    pacman -S --noconfirm distcc && \
	    sed -i 's/^BUILDENV=(!distcc/BUILDENV=(distcc/' /etc/makepkg.conf

RUN curl https://archlinuxarm.org/builder/xtools/x-tools6h.tar.xz | tar xJ 
RUn pacman -S --noconfirm python-pip && pip install dumb-init
RUN pwd && ls -l x-tools6h && chmod -R +rx /x-tools6h/arm-unknown-linux-gnueabihf/bin

RUN useradd -U -r distcc

ENV PATH=/x-tools6h/arm-unknown-linux-gnueabihf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Add to whitelist
RUN for file in gcc cc cpp g++ gcc ; do \
	f=/usr/lib/distcc/armv6l-unknown-linux-gnueabihf-$file; \
	[ -f "$f" ] || ln -s /usr/bin/distcc "$f"; \
	done

EXPOSE 3632

ENTRYPOINT ["/usr/sbin/dumb-init", "/usr/bin/distccd", "--no-detach", "--daemon", "--listen", "0.0.0.0"]
CMD ["--allow-private", "--verbose", "--log-level", "debug", "--log-stderr"]

