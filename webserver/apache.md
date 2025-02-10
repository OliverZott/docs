# Apache and Tomcat configs

- Apache Server / apache virtual host / windows host
  - `C:\Users\olive\AppData\Roaming\Apache24\conf\extra\httpd-vhosts.conf`  ...vhost config
  - `C:\Users\olive\AppData\Roaming\Apache24\conf\httpd.conf`  ...core config
  - `C:\Users\olive\AppData\Roaming\Apache24\htdocs`  ...Document Root: the default directory where your web content (HTML, CSS, JavaScript, images, etc.) is stored.

  - `C:\Windows\System32\drivers\etc\hosts`  ...system file maps hostnames to IP addresses, usefull for local testing.

- Tomcat/Lucee server
  - `C:\lucee\tomcat\conf\server.xml`

- apache commands
  - `.\httpd.exe -k status`
  - `.\httpd.exe -k runservice`  ...runs apache as a service which ensures Apache to start with your operating system and runs continuously.
  - `.\httpd.exe -k restart`

## Check Ports

- `netstat -ab` ...Lists ports and their corresponding applications
- `netstat -ab | findstr "Lucee Tomcat Apache"`
- `netstat -ano` ...Lists active network connections and listening ports, including the Process ID (PID), but without resolving executable names
- `netstat -ano | findstr ":80 " | findstr LISTEN`  ...filters for connections specifically on port 80 and shows the listening ones
- `tasklist /fi "PID eq 6292"` ...filters the task list to show only the process with PID 6292
- ``

## Apache problems

- Check Error messag with event viewer
  - `win + r` -> `eventvwr`
  - `Windows Logs`

- Compare configs  

  ```shell
  code --diff "C:\Users\olive\AppData\Roaming\Apache24\conf\httpd.conf" "C:\Users\olive\AppData\Local\Temp\pid-15192\httpd.conf"

  ```

- Check ports  
  `netstat -aon | findstr :80`
