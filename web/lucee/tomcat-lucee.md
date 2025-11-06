# Lucee & Tomcat Guide for Beginners

## What is Lucee?

Lucee is a **free, open-source** programming language that runs on Java. It's perfect for building web applications and is compatible with Adobe ColdFusion. Think of it as a powerful way to create dynamic websites that can connect to databases, handle forms, and much more.

### Why Use Lucee?

- ✅ **Free** - No licensing costs (unlike Adobe ColdFusion)
- ✅ **Fast** - Runs on Java for great performance
- ✅ **Easy to learn** - Simple syntax, great for beginners
- ✅ **Powerful** - Can do everything from simple websites to complex applications
- ✅ **Compatible** - Works with most ColdFusion code

## What is Tomcat?

**Apache Tomcat** is a web server that runs Java applications. Lucee needs Tomcat to work - think of Tomcat as the engine that powers your Lucee applications.

```
Your Web Browser ←→ Apache (Web Server) ←→ Tomcat (Java Server) ←→ Lucee (Your Code)
```

## Quick Start Guide

### 1. Check if Everything is Working

Open your web browser and go to:

- **Lucee Admin**: <http://localhost/lucee/admin/server.cfm>
- **Your Website**: <http://localhost/>

If these work, you're all set! If not, follow the troubleshooting section below.

### 2. Your First Lucee Page

Create a file called `hello.cfm` in your web directory with this content:

```html
<!DOCTYPE html>
<html>
<head>
    <title>My First Lucee Page</title>
</head>
<body>
    <h1>Hello from Lucee!</h1>
    
    <cfscript>
        // This is Lucee code
        myName = "World";
        currentTime = now();
    </cfscript>
    
    <p>Hello, <cfoutput>#myName#</cfoutput>!</p>
    <p>Current time: <cfoutput>#currentTime#</cfoutput></p>
    
    <!-- You can also use tags -->
    <cfset myNumber = 42>
    <p>My favorite number is: <cfoutput>#myNumber#</cfoutput></p>
</body>
</html>
```

Visit `http://localhost/hello.cfm` to see your page!

## Essential Lucee Commands

### Debugging Your Code

```html
<!-- Quick way to see what's in your variables -->
<cfdump var="#variables#">

<!-- See form data that was submitted -->
<cfdump var="#form#">

<!-- See URL parameters -->
<cfdump var="#url#">

<!-- Custom dump with label -->
<cfdump var="#myVariable#" label="My Variable">
```

### Working with Data

```html
<!-- Set variables -->
<cfset userName = "John">
<cfset userAge = 25>

<!-- Arrays (lists) -->
<cfset fruits = ["apple", "banana", "orange"]>

<!-- Structures (like objects) -->
<cfset user = {
    name: "John",
    age: 25,
    email: "john@example.com"
}>

<!-- Display them -->
<cfoutput>
    <p>Name: #user.name#</p>
    <p>Age: #user.age#</p>
    <p>First fruit: #fruits[1]#</p>
</cfoutput>
```

### Simple Database Query

```html
<cfquery name="getUsers" datasource="myDatabase">
    SELECT name, email 
    FROM users 
    WHERE active = 1
</cfquery>

<cfoutput query="getUsers">
    <p>#name# - #email#</p>
</cfoutput>
```

## Directory Structure

Here's where your important files are located:

### Windows Paths

```
📁 Apache Configuration
├── C:\Users\[username]\AppData\Roaming\Apache24\conf\httpd.conf (main config)
├── C:\Users\[username]\AppData\Roaming\Apache24\conf\extra\httpd-vhosts.conf (virtual hosts)
└── C:\Users\[username]\AppData\Roaming\Apache24\htdocs\ (your website files go here)

📁 Tomcat/Lucee Configuration  
├── C:\lucee\tomcat\conf\server.xml (Tomcat settings)
├── C:\lucee\tomcat\webapps\ROOT\ (your Lucee files)
└── C:\lucee\tomcat\logs\ (error logs)

📁 System Files
└── C:\Windows\System32\drivers\etc\hosts (local domain mapping)
```

### What Each File Does

- **httpd.conf**: Main Apache settings (ports, modules, basic config)
- **httpd-vhosts.conf**: Virtual hosts (multiple websites on one server)
- **server.xml**: Tomcat configuration (Java settings, ports)
- **hosts file**: Maps domain names to IP addresses for local testing

## Common Tasks

### Starting and Stopping Services

```bash
# Apache Commands (run in Apache directory)
.\httpd.exe -k start      # Start Apache
.\httpd.exe -k stop       # Stop Apache  
.\httpd.exe -k restart    # Restart Apache
.\httpd.exe -k status     # Check status

# Check if services are running
netstat -ano | findstr ":80"     # Check if port 80 is in use
netstat -ano | findstr ":8888"   # Check if port 8888 is in use (Tomcat)
```

### Creating a Local Development Site

1. **Add to hosts file** (`C:\Windows\System32\drivers\etc\hosts`):

   ```
   127.0.0.1    mysite.local
   ```

2. **Add virtual host** (`httpd-vhosts.conf`):

   ```apache
   <VirtualHost *:80>
       ServerName mysite.local
       DocumentRoot "C:/path/to/your/project"
       <Directory "C:/path/to/your/project">
           AllowOverride All
           Require all granted
       </Directory>
   </VirtualHost>
   ```

3. **Restart Apache** and visit `http://mysite.local`

## Troubleshooting

### Services Not Starting

**Problem**: Apache or Tomcat won't start

**Solutions**:

1. Check if ports are already in use:

   ```bash
   netstat -ano | findstr ":80"
   netstat -ano | findstr ":8888"
   ```

2. Check Windows Event Viewer:
   - Press `Win + R`, type `eventvwr`, press Enter
   - Go to `Windows Logs` → `Application`
   - Look for Apache or Tomcat errors

### Lucee Admin Not Working

**Problem**: Can't access <http://localhost/lucee/admin/server.cfm>

**Check these**:

1. Is Apache running? Check `http://localhost`
2. Is Tomcat running? Check Task Manager for Java processes
3. Check Apache error logs in `Apache24\logs\error.log`

### Code Not Working

**Problem**: Your `.cfm` files show as plain text or don't execute

**Solutions**:

1. Make sure file extension is `.cfm` or `.cfc`
2. Check that Lucee is properly connected to Apache
3. Look for errors in Tomcat logs: `C:\lucee\tomcat\logs\`

### Can't Connect to Database

**Problem**: Database queries fail

**Solutions**:

1. Check datasource in Lucee Admin
2. Verify database is running
3. Check connection details (server, username, password)

## Useful Resources

### Learning Lucee

- [Lucee Documentation](https://docs.lucee.org/)
- [Try Lucee Online](https://trycf.com/)
- [CFML Reference](https://cfdocs.org/)

### Quick Reference

- **File Extensions**: `.cfm` (pages), `.cfc` (components)
- **Default Ports**: Apache (80), Tomcat (8888), Lucee Admin (80/lucee/admin)
- **Comment Syntax**: `<!--- CFML comments --->` or `// script comments`

### Getting Help

- [Lucee Community](https://dev.lucee.org/)
- [Stack Overflow - Lucee](https://stackoverflow.com/questions/tagged/lucee)

## Next Steps

Once you're comfortable with the basics:

1. **Learn about Components** (`.cfc` files) for reusable code
2. **Set up a database** and practice queries
3. **Explore frameworks** like Coldbox or FW/1
4. **Learn about caching** to make your apps faster
5. **Study security** best practices for web applications

Remember: Start small, practice often, and don't be afraid to experiment!
