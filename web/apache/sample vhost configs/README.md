# Simple Apache Virtual Host Templates

Three basic templates to get you started with Apache virtual hosts. Pick the one that matches what you're trying to do.

## The Templates

### 1. Static Website (`01-static-spa-website.conf.template`)

**For:** HTML/CSS/JS websites, React, Vue, Angular apps

**What it does:**

- Serves your website files
- Redirects HTTP to HTTPS
- Makes single-page apps work properly

### 2. Simple App Proxy (`02-simple-app-proxy.conf.template`)

**For:** Node.js, Python, PHP apps running on a port (like localhost:3000)

**What it does:**

- Forwards requests to your app
- Handles HTTPS
- Your app doesn't need to worry about SSL

### 3. Advanced Proxy (`03-advanced-api-proxy.conf.template`)

**For:** Apps that need both API calls AND static files

**What it does:**

- Forwards `/api/` requests to your app
- Serves static files directly from Apache
- Good for APIs with documentation or admin pages

## How to Use

### Step 1: Pick Your Template

Choose the template that fits your needs and copy it:

```bash
sudo cp 01-static-spa-website.conf.template /etc/apache2/sites-available/mysite.conf
```

### Step 2: Edit the File

Change these things in your copied file:

- `your-domain.com` → your actual domain
- `/var/www/your-domain` → where your files are
- `localhost:3001` → where your app runs (if using proxy)
- SSL certificate paths

### Step 3: Enable Your Site

```bash
# Enable required modules
sudo a2enmod ssl rewrite
sudo a2enmod proxy proxy_http    # Only needed for proxy templates

# Enable your site
sudo a2ensite mysite.conf

# Test and restart
sudo apache2ctl configtest
sudo systemctl reload apache2
```

## SSL Certificates

Each template gives you two options:

**Option 1: Your own certificates**

```apache
SSLCertificateFile /path/to/your-cert.crt
SSLCertificateKeyFile /path/to/your-private.key
```

**Option 2: Let's Encrypt (recommended)**

```apache
SSLCertificateFile /etc/letsencrypt/live/your-domain.com/fullchain.pem
SSLCertificateKeyFile /etc/letsencrypt/live/your-domain.com/privkey.pem
Include /etc/letsencrypt/options-ssl-apache.conf
```

## Quick Examples

### Static Website

If you have a React app in `/var/www/myapp`:

1. Use template 1
2. Change `your-domain.com` to `myapp.com`
3. Change `/var/www/your-domain` to `/var/www/myapp`

### Node.js API

If you have a Node.js app running on port 3000:

1. Use template 2
2. Change `api.your-domain.com` to `api.myapp.com`
3. Change `localhost:3001` to `localhost:3000`

### API + Documentation

If you have an API on port 3000 AND static docs in `/var/www/docs`:

1. Use template 3
2. Set up both the API proxy and static file paths

## Need Help?

**Common problems:**

- **"Connection refused"** → Your app isn't running
- **"SSL error"** → Check your certificate paths
- **"404 errors"** → Check your DocumentRoot path
- **"Permission denied"** → Check file ownership (`sudo chown -R www-data:www-data /var/www/yoursite`)

**Check if it's working:**

```bash
# Test Apache config
sudo apache2ctl configtest

# Check if your site is enabled
sudo a2ensite --list

# View error logs
sudo tail -f /var/log/apache2/error.log
```
