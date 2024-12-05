# Bash Basics

**Bash** (Bourne Again Shell) is the most common shell used in Unix systems. It supports command substitution, piping, variables, condition testing, and looping, among other features1. Bash sets the prompt from PS1 which contains backslash escapes4.

**Zsh** (Z Shell) is highly interactive and customizable. It has floating-point support and hash data structures that Bash does not possess3. Zsh is more compatible with Bash and has additional features. If you’re familiar with Bash, you can switch to Zsh without learning a different syntax1. Zsh sets the prompt from percent escapes like %d4.

## ubuntu shell

- `cd ~` ... user home
- `cd /` ... root

### check os

```bash
cat /etc/os-release
lsb_release -a
hostnamectl
```

### set aliases

- `code ~/.bashrc` ... edit bashrc (scriptfile, running on login, containing config for terminal session)
- add `ls -l --color=auto` to bashrc to enable colored listed output for `ls` command
  - `alias ls="ls -l --color=auto"`
- `alias kc='kubectl'`
- `source ~/.bashrc` ... reload bashrc to take effect immediately

### env vars

- `printenv` ...show env vars [link](https://www3.ntu.edu.sg/home/ehchua/programming/howto/Environment_Variables.html#zz-3.1)
- `export MY_ENV_VAR=test`  ...set/overwrite env var [link](https://linuxhandbook.com/envsubst-command/)

### show/switch/beautify shell

Zsh is definitely more feature-rich and customizable, which is why it’s the default shell in MacOS terminals. However, Bash is more popular and widely used, especially for scripting purposes.

- `echo $0`
- `echo $SHELL`
- `chsh -s /bin/bash` ... change shell to bash
- <https://javascript.plainenglish.io/save-your-time-when-using-the-terminal-with-zsh-and-oh-my-zsh-8e51485afa91>
- <https://www.cyberciti.biz/faq/change-my-default-shell-in-linux-using-chsh/>

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
