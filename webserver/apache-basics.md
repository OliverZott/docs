# Apache Web Server Basics

## What is Apache?

... popular web server software. It serves web content (HTML, images, etc.) to users' browsers and can handle multiple websites on a single server.

## Key Components

### 1. Main Configuration Files

- `httpd.conf`: Core configuration file
- `httpd-vhosts.conf`: Virtual host configurations
- `.htaccess`: Per-directory configuration (if enabled)

### 2. Important Directories

- Document Root: Where website files are stored
- Log files: Access and error logs
- Modules: Additional functionality

## Common Configuration Elements

### Virtual Hosts

```apache
<VirtualHost *:80>
    ServerName example.com
    DocumentRoot /var/www/example
    ErrorLog /var/log/apache2/error.log
    CustomLog /var/log/apache2/access.log combined
</VirtualHost>
```

### Common Directives

- `Listen`: Port to listen on
- `ServerName`: Default server name
- `DocumentRoot`: Default web root
- `Directory`: Directory-specific settings
- `Allow/Deny`: Access control

## Essential Modules

- `mod_rewrite`: URL rewriting
- `mod_ssl`: Secure Sockets Layer (SSL) support
- `mod_proxy`: Reverse proxy
- `mod_auth`: Authentication

## Basic Commands

```bash
# Start Apache
apachectl start

# Stop Apache
apachectl stop

# Restart Apache
apachectl restart

# Test configuration
apachectl -t
```

## Common Tasks

### 1. Enable/Disable Sites

```bash
a2ensite example.com    # Enable site
a2dissite example.com   # Disable site
```

### 2. Enable/Disable Modules

```bash
a2enmod rewrite        # Enable module
a2dismod rewrite      # Disable module
```

### 3. Check Status

```bash
apachectl -S          # Show virtual hosts
apachectl -M          # Show loaded modules
```

## Security Basics

- Keep Apache updated
- Use HTTPS (Hypertext Transfer Protocol Secure) when possible
- Restrict directory access
- Hide server information
- Use strong authentication

## Resources

- [Apache Documentation](https://httpd.apache.org/docs/)
- [Apache Configuration Guide](https://httpd.apache.org/docs/2.4/configuring.html)

## Technical Deep Dive

### Request Flow

1. **DNS (Domain Name System) Resolution**
   - DNS servers can be deployed in different ways:
     - **Separate Hardware**: Dedicated physical server running DNS software
     - **Same Hardware**: Can run on same machine as Apache (not recommended for production)
     - **Cloud Service**: Managed DNS (e.g., AWS Route 53, Cloudflare)
     - **Container**: Running in Docker/Kubernetes
   - Common DNS server software:
     - BIND (Berkeley Internet Name Domain)
     - PowerDNS
     - Unbound
   - DNS resolution process:

     ```txt
     Client → Local DNS Cache → ISP (Internet Service Provider) DNS → Root DNS → TLD (Top Level Domain) DNS → Authoritative DNS
     ```

   - Authoritative DNS servers:
     - Store actual domain records
     - Can be managed by:
       - Domain registrar
       - Cloud providers (Route 53, Cloudflare)
       - Self-hosted DNS servers
   - Common DNS record types:
     - A: IPv4 (Internet Protocol version 4) address
     - AAAA: IPv6 (Internet Protocol version 6) address
     - CNAME (Canonical Name): Domain alias
     - MX (Mail Exchange): Mail server
     - TXT: Text records

   - **What DNS Does:**

        ```txt
        Input:  example.com
        ↓
        DNS Server looks up records
        ↓
        Output: 93.184.216.34 (IPv4 address)
        ```

   - translates human-readable domain names into IP addresses and also handles reverse lookups (IP → domain) and other record types

2. **Apache Processing**

   ```txt
   Client Request → DNS → Apache Server
                          ├── Virtual Host Matching
                          ├── URL Processing
                          ├── Module Processing
                          └── Response Generation
   ```

### Virtual Host Matching

- Apache checks `ServerName` and `ServerAlias`
- First matching virtual host handles request
- Default virtual host if no match
- Can match by:
  - IP address
  - Port number
  - Host name

### URL Processing

1. **Request URI Parsing**
   - Split into components (path, query, fragment)
   - Apply URL rewriting rules (mod_rewrite)
   - Map to filesystem location

2. **Directory Processing**

   ```txt
   URL: /blog/post.html
   ↓
   DocumentRoot: /var/www/
   ↓
   Final Path: /var/www/blog/post.html
   ```

### Module Processing Chain

1. **Request Phase**
   - Authentication (mod_auth)
   - Authorization
   - URL rewriting
   - MIME type detection

2. **Response Phase**
   - Content generation
   - Compression (mod_deflate)
   - Caching
   - Logging

### Common Configuration Patterns

#### 1. Reverse Proxy

```apache
<VirtualHost *:80>
    ServerName app.example.com
    ProxyPass / http://localhost:8080/
    ProxyPassReverse / http://localhost:8080/
</VirtualHost>
```

#### 2. URL Rewriting

```apache
RewriteEngine On
RewriteRule ^blog/([0-9]+)$ /blog.php?id=$1 [L]
```

#### 3. SSL Configuration

```apache
<VirtualHost *:443>
    SSLEngine on
    SSLCertificateFile /path/to/cert.pem
    SSLCertificateKeyFile /path/to/key.pem
</VirtualHost>
```

### Performance Considerations

- Keep-alive connections
- Worker MPM settings
- Caching strategies
- Compression settings
- Resource limits

### Debugging Tools

- `apachectl -S`: Virtual host settings
- `apachectl -M`: Loaded modules
- `apachectl -t`: Configuration test
- Error logs: `/var/log/apache2/error.log`
- Access logs: `/var/log/apache2/access.log`
