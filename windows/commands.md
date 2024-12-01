# Windows PS commands

<https://www.youtube.com/watch?v=Jfvg3CS1X3A>

- clear screen
  - `cls`
  - ctrl+l
- `findstr /i <STRING>` ...ignore case sensitivity
- `ipconfig /all | findstr DNS`
- `gci env: | findstr Prog`
- Copy to clipboard: `gci env: | clip`
- `powercfg /energy`
- `powercfg /batteryreport`
- `assoc` and `assoc .mp4=VLC.vlc`
- `chkdsk /f` `chkdsk /r` disk check
- `sfc` system file checker
- `netsh`

## Services

### Find services

- `Get-Service postgresql-x64-17`  ...get a specific service
- `sc query | findstr /i postgres` ...find postgres service
- `tasklist | findstr postgres` ...find postgres process
- `tasklist | findstr 18596` ...find service with id 18596
- `Get-Process -Id (Get-NetTCPConnection -LocalPort 5432).OwningProcess` ...check PORT
- `netstat -aon | findstr 5432` ...check PORT

### Restart service

- `net stop <servicename>` ...e.g. net start postgresql-x64-17
- `net start <servicename>`
- `Restart-Service postgresql-x64-17`  ...restart a specific service
