# DDEV for local development

Idea: use DDEV for wordpress development and version git repo of wp-site to later deploy to production.

## Install/Setup/Use DDEV

### Ubuntu and Docker

- install ubuntu in wsl
- install docker in ubuntu [docu](https://docs.docker.com/engine/install/ubuntu/)

```bash
sudo apt update
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
docker --version
sudo usermod -aG docker $USER
sudo apt install docker-compose
docker-compose --version
```

### Install DDEV

- [docu](https://ddev.readthedocs.io/en/stable/users/install/ddev-installation/)

```bash
# Add DDEV’s GPG key to your keyring
sudo sh -c 'echo ""'
sudo apt-get update && sudo apt-get install -y curl
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://pkg.ddev.com/apt/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/ddev.gpg > /dev/null
sudo chmod a+r /etc/apt/keyrings/ddev.gpg

# Add DDEV releases to your package repository
sudo sh -c 'echo ""'
echo "deb [signed-by=/etc/apt/keyrings/ddev.gpg] https://pkg.ddev.com/apt/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list >/dev/null

# Update package information and install DDEV
sudo sh -c 'echo ""'
sudo apt-get update && sudo apt-get install -y ddev

# One-time initialization of mkcert
mkcert -install
```

### Setup DDEV WordPress project

- [docu](https://ddev.readthedocs.io/en/stable/users/quickstart/#wordpress-wp-cli)

```bash
mkdir my-wp-site && cd my-wp-site

# Create a new DDEV project inside the newly-created folder
# (Primary URL automatically set to `https://<folder>.ddev.site`)
ddev config --project-type=wordpress
ddev start

# Download WordPress
ddev wp core download

# Launch in browser to finish installation
ddev launch

# OR use the following installation command
# (we need to use single quotes to get the primary site URL from `.ddev/config.yaml` as variable)
ddev wp core install --url='$DDEV_PRIMARY_URL' --title='New-WordPress' --admin_user=admin --admin_email=admin@example.com --prompt=admin_password

# Launch WordPress admin dashboard in your browser
ddev launch wp-admin/
```

### Error with ddev wp core download

<https://ddev.readthedocs.io/en/latest/users/install/docker-installation/#macos>
<https://github.com/ddev/ddev/issues/4586>

### Browser

- <https://my-wp-site.ddev.site/>
- <https://my-wp-side.ddev.site:33001/>
