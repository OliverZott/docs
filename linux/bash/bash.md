# Bash Basics

## ubuntu shell

- `cd ~` ... user home
- `cd /` ... root

### set aliases

- `code ~/.bashrc` ... edit bashrc (scriptfile, running on login, containing config for terminal session)
- add `ls -l --color=auto` to bashrc to enable colored listed output for `ls` command
  - `alias ls="ls -l --color=auto"`
- `alias kc='kubectl'`
- `source ~/.bashrc` ... reload bashrc to take effect immediately

### env vars

- `printenv` ...show env vars [link](https://www3.ntu.edu.sg/home/ehchua/programming/howto/Environment_Variables.html#zz-3.1)
- `export MY_ENV_VAR=test`  ...set/overwrite env var [link](https://linuxhandbook.com/envsubst-command/)

## imagemagick

<https://imagemagick.org/script/convert.php>

- `sudo apt install imagemagick`
- `convert -resize 20% in.jpg out.jpg`
- `magick rose.jpg -resize 50% rose.png`

## file operations

- [computer information](https://www.tecmint.com/commands-to-collect-system-and-hardware-information-in-linux/#:~:text=1.,kernel%20name%20of%20your%20system.&text=To%20view%20your%20network%20hostname,the%20uname%20command%20as%20shown.)
- [memory usage](https://phoenixnap.com/kb/linux-commands-check-memory-usage#:~:text=Checking%20Memory%20Usage%20in%20Linux%20using%20the%20GUI,-Using%20a%20graphical&text=Navigate%20to%20Show%20Applications.,including%20historical%20information%20is%20displayed.)
- [memory info](https://www.cyberciti.biz/faq/linux-ram-info-command/)
- `sudo lshw -html > hardwareinfo.html` ... create file with infos
- `sudo lshw` or `sudo lshw -short` ... computer information
- `lscpu` ... cpu information
- `sudo dmidecode -t processor` ... processor information
- `sudo dmidecode -t memory` ... memory information
- `sudo dmidecode -t bios` ... BIOS information
