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
- `sc query | findstr /i postgres` ...find postgres service
- `netstat -aon | findstr 5432` ...find port 5432
- `net stop <servicename>` ...e.g. net start postgresql-x64-17
- `tasklist | findstr postgres` ...find postgres process
- `tasklist | findstr 18596` ...find service with id 18596
-
