# Nginx Basics

**Nginx** (pronounced "engine-ex") is a powerful, lightweight web server that's become incredibly popular for modern web applications. Think of it as a super-efficient traffic director for your websites.

## Why Use Nginx?

- ✅ **Fast** - Handles thousands of connections with minimal resources
- ✅ **Great for reverse proxy** - Perfect for connecting to Node.js, Python, PHP apps
- ✅ **Load balancing** - Can distribute traffic across multiple servers
- ✅ **Static files** - Serves images, CSS, JS extremely efficiently
- ✅ **Easy configuration** - Simple, readable config files

## Nginx vs Apache

| Feature | Nginx | Apache |
|---------|-------|--------|
| **Performance** | Excellent with many connections | Good for smaller sites |
| **Memory Usage** | Very low | Higher |
| **Configuration** | Simple, block-based | More complex, many options |
| **Modules** | Built-in or compile-time | Dynamic loading |
| **Best For** | Reverse proxy, static files, high traffic | Traditional hosting, .htaccess |

## Understanding Reverse Proxy

### What is a Reverse Proxy? 🤔

A **reverse proxy** sits between your users and your application servers. Instead of users connecting directly to your app, they connect to Nginx, and Nginx forwards the requests to your app.

```text
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Browser   │───▶│   Nginx     │───▶│   Your App  │
│             │    │ (Port 80)   │    │ (Port 3000) │
└─────────────┘    └─────────────┘    └─────────────┘
```

### Why Use a Reverse Proxy?

**1. Hide Your App's Port**

- Users visit `yoursite.com` (port 80)
- Your app runs on `localhost:3000`
- Nginx forwards requests between them

**2. Handle SSL/HTTPS**

- Nginx handles all the SSL certificate stuff
- Your app doesn't need to worry about HTTPS
- Much simpler to manage certificates

**3. Serve Static Files Fast**

- Nginx serves images, CSS, JS directly
- Your app only handles dynamic content
- Much better performance

**4. Load Balancing**

- Run multiple copies of your app
- Nginx distributes traffic between them
- If one crashes, others keep working

**5. Multiple Apps on One Server**

- `api.yoursite.com` → Node.js app on port 3000
- `blog.yoursite.com` → WordPress on port 8080
- `app.yoursite.com` → React app files

## Basic Installation

### Windows (using Chocolatey)

```bash
# Install Chocolatey first if you don't have it
# Then install Nginx
choco install nginx

# Or download from nginx.org and extract to C:\nginx
```

### Linux (Ubuntu/Debian)

```bash
# Update package list
sudo apt update

# Install Nginx
sudo apt install nginx

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx
```

### macOS (using Homebrew)

```bash
# Install Homebrew first if you don't have it
# Then install Nginx
brew install nginx

# Start Nginx
brew services start nginx
```

## Essential Commands

### Linux/macOS

```bash
# Service management
sudo systemctl start nginx      # Start Nginx
sudo systemctl stop nginx       # Stop Nginx
sudo systemctl restart nginx    # Restart Nginx
sudo systemctl reload nginx     # Reload config without stopping

# Test configuration
sudo nginx -t                   # Test config file
sudo nginx -s reload            # Reload config

# Check status
sudo systemctl status nginx     # Service status
sudo netstat -tlnp | grep :80   # Check if port 80 is in use
```

### Windows

```bash
# Navigate to Nginx directory (usually C:\nginx)
cd C:\nginx

# Start Nginx
start nginx

# Stop Nginx
nginx -s stop

# Reload configuration
nginx -s reload

# Test configuration
nginx -t
```

## Configuration Basics

### Main Configuration File

**Linux**: `/etc/nginx/nginx.conf`  
**Windows**: `C:\nginx\conf\nginx.conf`

### Simple Static Website

```nginx
server {
    listen 80;
    server_name yoursite.com www.yoursite.com;
    
    # Where your website files are
    root /var/www/yoursite;
    index index.html index.htm;
    
    # Handle requests
    location / {
        try_files $uri $uri/ =404;
    }
}
```

### Single Page Application (React/Vue/Angular)

```nginx
server {
    listen 80;
    server_name myapp.com;
    
    root /var/www/myapp/dist;
    index index.html;
    
    # Handle SPA routing - send everything to index.html
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

## Reverse Proxy Examples

### Basic Reverse Proxy to Node.js

```nginx
server {
    listen 80;
    server_name api.yoursite.com;
    
    # Forward all requests to your Node.js app
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### Mixed Content (Static + API)

```nginx
server {
    listen 80;
    server_name yoursite.com;
    
    # Serve static files directly
    root /var/www/yoursite;
    index index.html;
    
    # Handle homepage and static pages
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # Forward API requests to your backend
    location /api/ {
        proxy_pass http://localhost:3000/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    
    # Serve static assets with caching
    location /static/ {
        expires 1y;
        add_header Cache-Control "public";
    }
}
```

### Multiple Applications

```nginx
# Frontend React app
server {
    listen 80;
    server_name app.yoursite.com;
    
    root /var/www/react-app/build;
    index index.html;
    
    location / {
        try_files $uri /index.html;
    }
}

# Backend API
server {
    listen 80;
    server_name api.yoursite.com;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}

# Admin panel
server {
    listen 80;
    server_name admin.yoursite.com;
    
    location / {
        proxy_pass http://localhost:4000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### Load Balancing

```nginx
# Define backend servers
upstream backend {
    server localhost:3000;
    server localhost:3001;
    server localhost:3002;
}

server {
    listen 80;
    server_name yoursite.com;
    
    location / {
        proxy_pass http://backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

## HTTPS/SSL Configuration

### Basic HTTPS Setup

```nginx
server {
    listen 80;
    server_name yoursite.com;
    
    # Redirect HTTP to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    server_name yoursite.com;
    
    # SSL certificates
    ssl_certificate /path/to/your/cert.pem;
    ssl_certificate_key /path/to/your/private.key;
    
    # Modern SSL settings
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Proto https;
    }
}
```

### Let's Encrypt SSL

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Get certificate
sudo certbot --nginx -d yoursite.com -d www.yoursite.com

# Certbot automatically updates your Nginx config!
```

## Common Directory Structure

### Linux

```text
/etc/nginx/
├── nginx.conf                 # Main configuration
├── sites-available/           # Available site configs
│   ├── default
│   ├── yoursite.com
│   └── api.yoursite.com
├── sites-enabled/             # Active site configs (symlinks)
│   ├── default -> ../sites-available/default
│   └── yoursite.com -> ../sites-available/yoursite.com
└── conf.d/                    # Additional configs
```

### Windows

```text
C:\nginx\
├── conf\
│   ├── nginx.conf             # Main configuration
│   └── sites\                 # Your site configs
│       ├── yoursite.conf
│       └── api.conf
├── html\                      # Default web files
└── logs\                      # Log files
```

## Useful Nginx Directives

### Performance

```nginx
# Worker processes (usually = CPU cores)
worker_processes auto;

# Max connections per worker
events {
    worker_connections 1024;
}

# Enable gzip compression
gzip on;
gzip_types text/plain text/css application/json application/javascript;

# Set client body size (for file uploads)
client_max_body_size 10M;
```

### Security

```nginx
# Hide Nginx version
server_tokens off;

# Security headers
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;
add_header X-XSS-Protection "1; mode=block";

# Rate limiting
limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;

location /api/ {
    limit_req zone=api burst=20 nodelay;
    proxy_pass http://localhost:3000;
}
```

## Troubleshooting

### Common Issues

**1. Nginx won't start**

```bash
# Check configuration
sudo nginx -t

# Check what's using port 80
sudo netstat -tlnp | grep :80

# Check logs
sudo tail -f /var/log/nginx/error.log
```

**2. 502 Bad Gateway**

- Your backend app isn't running
- Wrong proxy_pass URL
- Firewall blocking internal connections

**3. 404 Not Found**

- Check root directory path
- Verify file permissions
- Check try_files directive

**4. Permission denied**

```bash
# Fix file ownership
sudo chown -R www-data:www-data /var/www/yoursite

# Fix permissions
sudo chmod -R 755 /var/www/yoursite
```

### Useful Commands

```bash
# Test configuration
sudo nginx -t

# Reload without stopping
sudo nginx -s reload

# Check active connections
sudo netstat -tlnp | grep nginx

# Monitor access logs
sudo tail -f /var/log/nginx/access.log

# Monitor error logs
sudo tail -f /var/log/nginx/error.log
```

## Quick Reference

### Enable a Site (Linux)

```bash
# Create config file
sudo nano /etc/nginx/sites-available/yoursite.com

# Enable the site
sudo ln -s /etc/nginx/sites-available/yoursite.com /etc/nginx/sites-enabled/

# Test and reload
sudo nginx -t && sudo systemctl reload nginx
```

### Basic Proxy Headers

```nginx
proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
```

### Common Locations

| Purpose | Location Block |
|---------|----------------|
| All requests | `location / { }` |
| API endpoints | `location /api/ { }` |
| Static files | `location /static/ { }` |
| Images | `location ~* \.(jpg|png|gif)$ { }` |
| Admin area | `location /admin/ { }` |

## Next Steps

Once you're comfortable with basics:

1. **Learn about caching** (proxy_cache)
2. **Set up monitoring** (access logs, error logs)
3. **Explore modules** (auth, rate limiting)
4. **Study performance tuning** (worker settings, buffers)
5. **Implement security** (fail2ban, rate limiting)

Nginx is incredibly powerful once you understand the basics. Start simple and gradually add complexity as you need it!
