# SSH

- To generate: `ssh-keygen`  ...often one SSH key for various apps
- Default location:
  - windows: `C:\Users\<user>\.ssh`
  - linux: `$HOME/.ssh/` or in short `~/.ssh`

## Example - DataGrip

To connect to external database with datagrip with SSH:

1. local machine: `ssh-keygen`
1. external server:

    ```shell
    sudo su
    nano /root/.ssh/authorized_keys  # add pub key from lcoal machine there
    ```

1. local machine: set private key in datagrip properties under SSH/SSL

## Example - GitLab
