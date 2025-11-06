# Apache & Tomcat Configuration Guide

## Understanding the Setup

When you run Lucee, you actually have **two servers** working together:

1. **Apache** - The front-end web server (handles HTTP requests)
2. **Tomcat** - The back-end Java server (runs your Lucee code)

```text
Browser → Apache (Port 80) → Tomcat (Port 8888) → Lucee Code
```

## Important File Locations

### Apache Files (Windows)

```text
📁 Main Configuration
├── C:\Users\[username]\AppData\Roaming\Apache24\conf\httpd.conf
│   └── Core Apache settings (ports, modules, basic config)
│
├── C:\Users\[username]\AppData\Roaming\Apache24\conf\extra\httpd-vhosts.conf  
│   └── Virtual host configurations (multiple websites)
│
└── C:\Users\[username]\AppData\Roaming\Apache24\htdocs\
    └── Your website files go here (DocumentRoot)
```

### Tomcat/Lucee Files

```text
📁 Tomcat Configuration
├── C:\lucee\tomcat\conf\server.xml
│   └── Tomcat settings (ports, connectors)
│
├── C:\lucee\tomcat\webapps\ROOT\
│   └── Your Lucee applications
│
└── C:\lucee\tomcat\logs\
    └── Error logs and debug information
```

### System Files

```text
📁 Windows System
└── C:\Windows\System32\drivers\etc\hosts
    └── Maps domain names to IP addresses for local testing
```

## Managing Your Services

### Apache Commands

Run these commands in your Apache directory (`C:\Users\[username]\AppData\Roaming\Apache24\bin\`):

```bash
# Basic service management
.\httpd.exe -k start      # Start Apache
.\httpd.exe -k stop       # Stop Apache  
.\httpd.exe -k restart    # Restart Apache
.\httpd.exe -k status     # Check if Apache is running

# Run as Windows service (starts with computer)
.\httpd.exe -k install    # Install as service
.\httpd.exe -k runservice # Run as service
.\httpd.exe -k uninstall  # Remove service
```

### Quick Status Checks

```bash
# Check what's using your ports
netstat -ano | findstr ":80"     # Check port 80 (Apache)
netstat -ano | findstr ":8888"   # Check port 8888 (Tomcat)

# Find what program is using a specific port
netstat -ano | findstr ":80" | findstr LISTEN
tasklist /fi "PID eq [PID_NUMBER]"

# Quick overview of all connections
netstat -ab | findstr "Apache Tomcat Lucee"
```

## Setting Up Local Development

### 1. Create a Local Domain

**Edit hosts file** (`C:\Windows\System32\drivers\etc\hosts`):

```text
# Add this line (without the #)
127.0.0.1    myproject.local
127.0.0.1    api.myproject.local
```

### 2. Configure Virtual Host

**Edit Apache vhosts** (`httpd-vhosts.conf`):

```apache
# Basic virtual host for static files
<VirtualHost *:80>
    ServerName myproject.local
    DocumentRoot "C:/projects/myproject"
    
    <Directory "C:/projects/myproject">
        AllowOverride All
        Require all granted
    </Directory>
    
    # Optional: Custom log files
    ErrorLog "logs/myproject_error.log"
    CustomLog "logs/myproject_access.log" combined
</VirtualHost>

# Virtual host for Lucee application
<VirtualHost *:80>
    ServerName app.myproject.local
    DocumentRoot "C:/projects/myproject/app"
    
    # Proxy .cfm files to Tomcat
    ProxyPreserveHost On
    ProxyPass *.cfm http://localhost:8888/
    ProxyPassReverse *.cfm http://localhost:8888/
    
    <Directory "C:/projects/myproject/app">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

### 3. Test Your Setup

1. **Restart Apache**: `.\httpd.exe -k restart`
2. **Visit your sites**:
   - `http://myproject.local` (static files)
   - `http://app.myproject.local` (Lucee app)

## Common Configuration Tasks

### Adding a New Website

1. **Create project folder**: `C:\projects\newsite\`
2. **Add to hosts file**: `127.0.0.1 newsite.local`
3. **Add virtual host**:

```apache
<VirtualHost *:80>
    ServerName newsite.local
    DocumentRoot "C:/projects/newsite"
    <Directory "C:/projects/newsite">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

4. **Restart Apache**

### Enabling HTTPS (SSL)

```apache
<VirtualHost *:443>
    ServerName myproject.local
    DocumentRoot "C:/projects/myproject"
    
    SSLEngine on
    SSLCertificateFile "conf/ssl/myproject.crt"
    SSLCertificateKeyFile "conf/ssl/myproject.key"
    
    <Directory "C:/projects/myproject">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

## Troubleshooting Common Issues

### Apache Won't Start

**Check for port conflicts:**

```bash
netstat -ano | findstr ":80"
```

If something else is using port 80:

1. **Stop the conflicting service** (often IIS or Skype)
2. **Change Apache port** in `httpd.conf`:

   ```apache
   Listen 8080
   ```

3. **Access via**: `http://localhost:8080`

### Configuration Errors

**Test your config:**

```bash
.\httpd.exe -t
```

**Common fixes:**

- Check file paths use forward slashes: `C:/path/to/file`
- Ensure directories exist before referencing them
- Check for typos in ServerName directives

### View Error Messages

**Windows Event Viewer:**

1. Press `Win + R`, type `eventvwr`, press Enter
2. Go to `Windows Logs` → `Application`
3. Look for Apache HTTP Service errors

**Apache Error Logs:**

```bash
# View recent errors
tail logs/error.log

# Watch errors in real-time (if you have tail command)
tail -f logs/error.log
```

### Compare Configurations

**Use VS Code to compare configs:**

```bash
code --diff "C:\Users\olive\AppData\Roaming\Apache24\conf\httpd.conf" "C:\backup\httpd.conf"
```

## Performance Tips

### Basic Optimization

**Enable compression** in `httpd.conf`:

```apache
LoadModule deflate_module modules/mod_deflate.so

<Location />
    SetOutputFilter DEFLATE
    SetEnvIfNoCase Request_URI \
        \.(?:gif|jpe?g|png)$ no-gzip dont-vary
</Location>
```

**Enable caching:**

```apache
LoadModule expires_module modules/mod_expires.so

<Directory "C:/your/website">
    ExpiresActive On
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
    ExpiresByType image/png "access plus 1 year"
</Directory>
```

## Security Basics

### Hide Server Information

**In `httpd.conf`:**

```apache
ServerTokens Prod
ServerSignature Off
```

### Disable Directory Browsing

```apache
<Directory "C:/your/website">
    Options -Indexes
</Directory>
```

### Restrict Access to Admin Areas

```apache
<Directory "C:/your/website/admin">
    Require ip 127.0.0.1
    Require ip 192.168.1.0/24
</Directory>
```

## Quick Reference

### Essential Commands

```bash
# Service management
.\httpd.exe -k start|stop|restart

# Testing
.\httpd.exe -t                    # Test configuration
.\httpd.exe -S                    # Show virtual hosts

# Monitoring  
netstat -ano | findstr ":80"     # Check port usage
tasklist | findstr httpd         # Find Apache processes
```

### Key Configuration Files

| File | Purpose | Location |
|------|---------|----------|
| `httpd.conf` | Main config | `Apache24\conf\` |
| `httpd-vhosts.conf` | Virtual hosts | `Apache24\conf\extra\` |
| `server.xml` | Tomcat config | `lucee\tomcat\conf\` |
| `hosts` | Local domains | `Windows\System32\drivers\etc\` |

### Default Ports

- **Apache HTTP**: 80
- **Apache HTTPS**: 443  
- **Tomcat**: 8888
- **Lucee Admin**: 80/lucee/admin

Remember: Always restart Apache after making configuration changes!
