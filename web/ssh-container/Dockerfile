FROM alpine:3.24

RUN apk add --no-cache openssh \
    && ssh-keygen -A \
    && echo "root:demo" | chpasswd \
    && sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
CMD ["/usr/sbin/sshd", "-D", "-e"]
