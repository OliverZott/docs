# Lucee Development Guide

Welcome to your beginner-friendly guide for developing with Lucee! This folder contains everything you need to get started with Lucee development on Windows.

## What's in This Folder?

### 📚 Documentation Files

- **[tomcat-lucee.md](tomcat-lucee.md)** - Complete beginner's guide to Lucee development
- **[apache.md](apache.md)** - Apache & Tomcat configuration for Lucee

## Quick Start

New to Lucee? Start here:

1. **Read the basics**: [tomcat-lucee.md](tomcat-lucee.md)
2. **Set up your environment**: [apache.md](apache.md)
3. **Create your first page** (see example below)

### Your First Lucee Page

Create `hello.cfm` in your web directory:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Hello Lucee!</title>
</head>
<body>
    <h1>My First Lucee Page</h1>
    
    <cfset myName = "Developer">
    <cfset currentTime = now()>
    
    <p>Hello, <cfoutput>#myName#</cfoutput>!</p>
    <p>Current time: <cfoutput>#dateFormat(currentTime, "dd/mm/yyyy")# #timeFormat(currentTime, "HH:mm:ss")#</cfoutput></p>
    
    <cfdump var="#server#" label="Server Information">
</body>
</html>
```

Visit: `http://localhost/hello.cfm`

## Essential Links

- **Lucee Admin**: <http://localhost/lucee/admin/server.cfm>
- **Local Website**: <http://localhost/>
- **Lucee Documentation**: <https://docs.lucee.org/>

## Common Tasks

### Check if Services are Running

```bash
# Check Apache (port 80)
netstat -ano | findstr ":80"

# Check Tomcat (port 8888)  
netstat -ano | findstr ":8888"
```

### Restart Services

```bash
# Restart Apache
cd "C:\Users\[username]\AppData\Roaming\Apache24\bin"
.\httpd.exe -k restart
```

### Create a New Local Site

1. **Add to hosts file**: `C:\Windows\System32\drivers\etc\hosts`

   ```
   127.0.0.1    mysite.local
   ```

2. **Add virtual host**: Edit `httpd-vhosts.conf`

   ```apache
   <VirtualHost *:80>
       ServerName mysite.local
       DocumentRoot "C:/projects/mysite"
       <Directory "C:/projects/mysite">
           AllowOverride All
           Require all granted
       </Directory>
   </VirtualHost>
   ```

3. **Restart Apache**

## Troubleshooting

### Services Won't Start

- Check port conflicts: `netstat -ano | findstr ":80"`
- Check Windows Event Viewer: `Win+R` → `eventvwr`

### Lucee Pages Not Working

- Ensure file extension is `.cfm`
- Check Tomcat is running
- Verify Apache-Tomcat connection

### Need Help?

- Check the [troubleshooting sections](tomcat-lucee.md#troubleshooting) in our guides
- Visit [Lucee Community](https://dev.lucee.org/)
- Ask on [Stack Overflow](https://stackoverflow.com/questions/tagged/lucee)

## What's Next?

Once you're comfortable with the basics:

1. **Learn about Components** (`.cfc` files)
2. **Set up a database** connection
3. **Explore frameworks** like Coldbox
4. **Study security** best practices

Happy coding! 🚀
