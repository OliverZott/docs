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

- `Get-Process -Id (Get-NetTCPConnection -LocalPort 5432).OwningProcess` check PORT
- `Get-Service postgresql-x64-17`  ...get a specific service
- `Restart-Service postgresql-x64-17`  ...restart a specific service
