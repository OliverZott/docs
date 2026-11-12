# Bastion / Jump Host

- `ssh -p 2222 root@localhost` password `demo`

## How it works

### 1. SSH server in a container

```sh
RUN apk add openssh && ssh-keygen -A           # install sshd and generate host keys
    && echo "root:demo" | chpasswd             # set root's password
    && sed ... PermitRootLogin yes             # allow root to log in
CMD ["/usr/sbin/sshd", "-D", "-e"]             # run sshd in the foreground as the container's main process
```

### 2. Port mapping

```sh
ports: ["2222:22"]    # host port 2222 → container port 22
```

### 3. Bind mount (compose), the key part

```sh
volumes: ["/:/root"]  # host's / appears inside the container at /root
```

```md
 You (WSL terminal)
   │
   │ ssh -p 2222 root@localhost
   ▼
┌──────────────── WSL host (one Linux kernel) ──────────────────┐
│                                                               │
│  Port 2222 ──(Docker forwards)──► Container port 22           │
│                                    │                          │
│                     ┌──────────────▼───────────────┐          │
│                     │ Container (Alpine)           │          │
│                     │  sshd → gives you a shell    │          │
│                     │                              │          │
│                     │  /bin, /etc … container's own│          │
│                     │  /root ─────────┐ (mount)    │          │
│                     └─────────────────┼────────────┘          │
│                                       │                       │
│  Host disk:  /  /home  /etc  …  ◄─────┘ same files            │
└───────────────────────────────────────────────────────────────┘
```
