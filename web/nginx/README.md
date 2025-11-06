# Nginx Documentation

Welcome to your beginner-friendly Nginx guide! This folder contains everything you need to understand and use Nginx effectively.

## What's in This Folder?

### 📚 Main Documentation

- **[nginx-basics.md](nginx-basics.md)** - Complete Nginx guide from installation to advanced features
- **[reverse-proxy-guide.md](reverse-proxy-guide.md)** - Detailed explanation of reverse proxies (the confusing part made simple!)

### 📁 Sample Configurations

The `sample configs/` folder contains ready-to-use templates:

- **[01-static-website.conf.template](sample%20configs/01-static-website.conf.template)** - For HTML/CSS/JS sites and SPAs
- **[02-simple-reverse-proxy.conf.template](sample%20configs/02-simple-reverse-proxy.conf.template)** - Basic app proxying
- **[03-mixed-content.conf.template](sample%20configs/03-mixed-content.conf.template)** - Static files + API together

## Quick Start Guide

### New to Nginx? Start Here

1. **Understand the basics**: Read [nginx-basics.md](nginx-basics.md)
2. **Learn reverse proxy**: Read [reverse-proxy-guide.md](reverse-proxy-guide.md)
3. **Pick a template**: Choose from `sample configs/` folder
4. **Set up your first site** (see below)

### Your First Nginx Site

1. **Install Nginx** (see installation guide in basics)

2. **Create a simple site config:**

   ```nginx
   server {
       listen 80;
       server_name mysite.local;
       
       root /var/www/mysite;
       index index.html;
       
       location / {
           try_files $uri $uri/ =404;
       }
   }
   ```

3. **Add to hosts file** (`/etc/hosts` or `C:\Windows\System32\drivers\etc\hosts`):

   ```
   127.0.0.1 mysite.local
   ```

4. **Test and reload:**

   ```bash
   sudo nginx -t
   sudo nginx -s reload
   ```

5. **Visit:** `http://mysite.local`

## What is Nginx Good For?

### ✅ **Perfect For:**

- **Reverse proxy** - Hide your app behind a clean URL
- **Static files** - Serve images, CSS, JS super fast  
- **Load balancing** - Distribute traffic across multiple servers
- **SSL termination** - Handle HTTPS certificates in one place
- **High traffic sites** - Handles thousands of connections efficiently

### 🤔 **Maybe Not Best For:**

- **Simple local development** - Apache might be easier for beginners
- **Dynamic content only** - If you don't need static file serving
- **Windows-heavy environments** - Apache has better Windows integration

## Common Use Cases

### 1. **Frontend + Backend Setup**

```
yoursite.com     → React/Vue app (static files)
api.yoursite.com → Node.js/Python API (proxy)
```

### 2. **Microservices**

```
app.yoursite.com    → Main application
auth.yoursite.com   → Authentication service  
admin.yoursite.com  → Admin panel
```

### 3. **Development Environment**

```
myproject.local     → Your main site
api.myproject.local → Your API
cdn.myproject.local → Static assets
```

## Nginx vs Apache vs Others

| Feature | Nginx | Apache | IIS |
|---------|-------|--------|-----|
| **Performance** | Excellent | Good | Good |
| **Memory Usage** | Very Low | Medium | High |
| **Configuration** | Simple | Complex | GUI-based |
| **Reverse Proxy** | Excellent | Good | Good |
| **Windows Support** | Basic | Excellent | Native |
| **Learning Curve** | Medium | Steep | Easy |

## Essential Commands

### Linux/macOS

```bash
# Service management
sudo systemctl start nginx
sudo systemctl stop nginx  
sudo systemctl restart nginx
sudo systemctl reload nginx

# Configuration
sudo nginx -t                # Test config
sudo nginx -s reload         # Reload config
```

### Windows

```bash
# Navigate to Nginx directory
cd C:\nginx

# Basic operations
start nginx                  # Start
nginx -s stop               # Stop  
nginx -s reload             # Reload
nginx -t                    # Test config
```

## Quick Troubleshooting

### Services Won't Start

```bash
# Check what's using port 80
sudo netstat -tlnp | grep :80

# Check Nginx status
sudo systemctl status nginx

# View error logs
sudo tail -f /var/log/nginx/error.log
```

### 502 Bad Gateway

- Check if your backend app is running
- Verify `proxy_pass` URL is correct
- Check firewall settings

### 404 Not Found

- Verify `root` directory exists
- Check file permissions
- Ensure `index` file exists

## Learning Path

### Beginner (Start here!)

1. Read [nginx-basics.md](nginx-basics.md) introduction
2. Install Nginx and create first static site
3. Learn basic `server` blocks and `location` directives

### Intermediate

1. Understand [reverse-proxy-guide.md](reverse-proxy-guide.md)
2. Set up proxy for a Node.js/Python app
3. Configure SSL/HTTPS
4. Use the template configurations

### Advanced

1. Learn load balancing with `upstream`
2. Implement caching strategies
3. Set up rate limiting and security
4. Optimize for high traffic

## Helpful Resources

### Official Documentation

- [Nginx Documentation](http://nginx.org/en/docs/)
- [Nginx Configuration Guide](http://nginx.org/en/docs/beginners_guide.html)

### Community Resources

- [Nginx Reddit](https://www.reddit.com/r/nginx/)
- [Stack Overflow - Nginx](https://stackoverflow.com/questions/tagged/nginx)

### Tools

- [Nginx Config Generator](https://www.digitalocean.com/community/tools/nginx)
- [SSL Test](https://www.ssllabs.com/ssltest/)

## Need Help?

### Check These First

1. **Configuration syntax**: `sudo nginx -t`
2. **Error logs**: `tail -f /var/log/nginx/error.log`
3. **Process status**: `sudo systemctl status nginx`
4. **Port conflicts**: `sudo netstat -tlnp | grep :80`

### Common Solutions

- **Permission denied**: Check file ownership and permissions
- **Connection refused**: Verify backend service is running
- **Config errors**: Check syntax and file paths
- **SSL issues**: Verify certificate paths and permissions

Remember: Nginx is powerful but simple once you understand the basics. Start with static files, then move to reverse proxy as you need it! 🚀
