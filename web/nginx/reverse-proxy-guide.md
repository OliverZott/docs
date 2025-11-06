# Understanding Reverse Proxy with Nginx

## What is a Reverse Proxy? (Simple Explanation)

Imagine you run a restaurant:

- **Without Reverse Proxy**: Customers walk directly to the kitchen and order from the chef
- **With Reverse Proxy**: Customers talk to a waiter, who takes orders to the kitchen and brings food back

The **waiter is the reverse proxy** - they handle communication between customers and the kitchen.

```text
Customer → Waiter → Kitchen
Browser  → Nginx  → Your App
```

## Why Use a Reverse Proxy?

### 1. **Hide Your App's Details** 🔒

**Without reverse proxy:**

- Users must visit: `yoursite.com:3000`
- Looks unprofessional
- Exposes internal structure

**With reverse proxy:**

- Users visit: `yoursite.com`
- Clean, professional URLs
- Your app's port is hidden

### 2. **Handle SSL/HTTPS** 🔐

**Without reverse proxy:**

- Your app must handle SSL certificates
- Complex SSL configuration in your code
- Each app needs its own SSL setup

**With reverse proxy:**

- Nginx handles ALL SSL stuff
- Your app just receives HTTP requests
- One place to manage certificates

### 3. **Performance** ⚡

**Without reverse proxy:**

- Your app serves everything (images, CSS, API)
- Slower response times
- App does too many things

**With reverse proxy:**

- Nginx serves static files (images, CSS, JS)
- Your app only handles business logic
- Much faster website

### 4. **Multiple Apps on One Server** 🏗️

**Without reverse proxy:**

- Each app needs different ports
- `api.yoursite.com:3000`, `blog.yoursite.com:8080`
- Complex DNS management

**With reverse proxy:**

- All apps use standard ports (80/443)
- `api.yoursite.com`, `blog.yoursite.com`
- Clean subdomain management

## Real-World Example

Let's say you have:

- A React frontend
- A Node.js API
- A WordPress blog

### Traditional Setup (Complex)

```text
yoursite.com:3000     → React app
yoursite.com:3001     → Node.js API  
yoursite.com:8080     → WordPress
```

Users must remember ports, SSL is complicated, looks unprofessional.

### Reverse Proxy Setup (Clean)

```text
yoursite.com          → React app
api.yoursite.com      → Node.js API
blog.yoursite.com     → WordPress
```

All use standard ports, clean URLs, centralized SSL.

## How Reverse Proxy Works

### Step-by-Step Process

1. **User visits `yoursite.com`**
2. **DNS points to your server** (where Nginx runs)
3. **Nginx receives the request** on port 80/443
4. **Nginx checks its configuration** to see where to send the request
5. **Nginx forwards request** to your app (e.g., `localhost:3000`)
6. **Your app processes** and returns response
7. **Nginx sends response** back to user

```text
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Browser   │───▶│   Nginx     │───▶│  Your App   │
│             │    │ (Port 80)   │    │ (Port 3000) │
│yoursite.com │◀───│             │◀───│             │
└─────────────┘    └─────────────┘    └─────────────┘
```

## Basic Reverse Proxy Configuration

### Simple Example

```nginx
server {
    listen 80;
    server_name yoursite.com;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

**What this does:**

- Listens for requests to `yoursite.com`
- Forwards ALL requests to `localhost:3000`
- Passes user's IP address to your app

### More Realistic Example

```nginx
server {
    listen 80;
    server_name yoursite.com;
    
    # Homepage and static pages
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    
    # API endpoints
    location /api/ {
        proxy_pass http://localhost:3001/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
    
    # Static files served directly by Nginx
    location /images/ {
        root /var/www/static;
        expires 1y;
    }
}
```

## Understanding Proxy Headers

When Nginx forwards requests, it needs to tell your app useful information:

### Essential Headers

```nginx
proxy_set_header Host $host;
```

**What it does:** Tells your app what domain the user visited  
**Example:** Your app knows user visited `yoursite.com`, not `localhost:3000`

```nginx
proxy_set_header X-Real-IP $remote_addr;
```

**What it does:** Gives your app the user's real IP address  
**Without this:** Your app thinks all requests come from `127.0.0.1`

```nginx
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
```

**What it does:** Passes along the chain of IP addresses  
**Useful for:** Logging, security, geolocation

```nginx
proxy_set_header X-Forwarded-Proto $scheme;
```

**What it does:** Tells your app if the original request was HTTP or HTTPS  
**Useful for:** Redirects, security checks

## Common Patterns

### Pattern 1: Frontend + Backend

```nginx
server {
    listen 80;
    server_name myapp.com;
    
    # Serve React/Vue frontend
    location / {
        proxy_pass http://localhost:3000;
    }
}

server {
    listen 80;
    server_name api.myapp.com;
    
    # Serve backend API
    location / {
        proxy_pass http://localhost:3001;
    }
}
```

### Pattern 2: Mixed Content

```nginx
server {
    listen 80;
    server_name myapp.com;
    
    # Static frontend files
    root /var/www/myapp;
    
    location / {
        try_files $uri /index.html;
    }
    
    # Dynamic API requests
    location /api/ {
        proxy_pass http://localhost:3001/;
    }
    
    # User uploads
    location /uploads/ {
        proxy_pass http://localhost:3001/uploads/;
    }
}
```

### Pattern 3: Load Balancing

```nginx
upstream backend {
    server localhost:3000;
    server localhost:3001;
    server localhost:3002;
}

server {
    listen 80;
    server_name myapp.com;
    
    location / {
        proxy_pass http://backend;
    }
}
```

## WebSocket Support

For real-time apps (chat, notifications):

```nginx
server {
    listen 80;
    server_name myapp.com;
    
    location / {
        proxy_pass http://localhost:3000;
        
        # WebSocket specific headers
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_cache_bypass $http_upgrade;
    }
}
```

## Security with Reverse Proxy

### Rate Limiting

```nginx
# Define rate limit zone
limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;

server {
    listen 80;
    server_name api.myapp.com;
    
    location / {
        # Apply rate limiting
        limit_req zone=api burst=20 nodelay;
        proxy_pass http://localhost:3000;
    }
}
```

### IP Restrictions

```nginx
server {
    listen 80;
    server_name admin.myapp.com;
    
    # Only allow specific IPs
    allow 192.168.1.0/24;
    allow 10.0.0.0/8;
    deny all;
    
    location / {
        proxy_pass http://localhost:3000;
    }
}
```

## Troubleshooting Reverse Proxy

### Common Issues

**1. 502 Bad Gateway**

- Your backend app isn't running
- Wrong `proxy_pass` URL
- App crashed or is restarting

**Check:**

```bash
# Is your app running?
curl http://localhost:3000

# Check Nginx error logs
sudo tail -f /var/log/nginx/error.log
```

**2. 504 Gateway Timeout**

- Your app is too slow to respond
- Long-running requests

**Fix:**

```nginx
location / {
    proxy_pass http://localhost:3000;
    proxy_read_timeout 300s;
    proxy_connect_timeout 300s;
}
```

**3. Lost User Information**

- App doesn't know user's real IP
- App thinks all requests come from localhost

**Fix:** Add proper headers

```nginx
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
```

### Debugging Tips

**Test backend directly:**

```bash
curl http://localhost:3000/api/users
```

**Test through Nginx:**

```bash
curl http://yoursite.com/api/users
```

**Check if Nginx can reach backend:**

```bash
# From the server
curl -H "Host: yoursite.com" http://localhost/api/users
```

## Best Practices

### 1. Always Set Headers

```nginx
proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
```

### 2. Use Upstream for Multiple Servers

```nginx
upstream myapp {
    server localhost:3000;
    server localhost:3001 backup;
}

server {
    location / {
        proxy_pass http://myapp;
    }
}
```

### 3. Set Reasonable Timeouts

```nginx
proxy_connect_timeout 60s;
proxy_send_timeout 60s;
proxy_read_timeout 60s;
```

### 4. Enable Buffering for Performance

```nginx
proxy_buffering on;
proxy_buffer_size 4k;
proxy_buffers 8 4k;
```

## Quick Reference

### Basic Proxy Block

```nginx
location / {
    proxy_pass http://localhost:3000;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```

### Proxy with Path Rewriting

```nginx
# Remove /api from URL when forwarding
location /api/ {
    proxy_pass http://localhost:3000/;
}

# Keep /api in URL when forwarding  
location /api/ {
    proxy_pass http://localhost:3000/api/;
}
```

The key is understanding that reverse proxy is just a middleman that makes everything cleaner and more professional!
