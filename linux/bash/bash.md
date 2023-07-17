# Bash Basics

## ubuntu shell

- `cd ~` ... user home
- `cd /` ... root

- `code ~/.bashrc` ... edit bashrc (scriptfile, running on login, containing config for terminal session)
- add `ls -l --color=auto` to bashrc to enable colored listed output for `ls` command
  - alias ls="ls -l --color=auto"

- `printenv` ...show env vars [link](https://www3.ntu.edu.sg/home/ehchua/programming/howto/Environment_Variables.html#zz-3.1)
- `export MY_ENV_VAR=test`  ...set/overwrite env var [link](https://linuxhandbook.com/envsubst-command/)

## imagemagick

<https://imagemagick.org/script/convert.php>

- `sudo apt install imagemagick`
- `convert -resize 20% in.jpg out.jpg`
- `magick rose.jpg -resize 50% rose.png`
