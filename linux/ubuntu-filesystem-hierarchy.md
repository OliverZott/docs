# Ubuntu Filesystem

```bash
cd ~  # home directory like C:\ in Windows
cd /  # root directory
tree -L3 /  # list directories and files in tree format (up to 3rd level beginning at root dir)
tree -L2 ~  # list directories and files in tree format (up to 2nd level beginning at home dir)
```

Navigation example to .ssh dir

```shell
# from home
cd ~
cd .ssh

# from root
cd /
cd /home/myname/.ssh/
```

<https://i.stack.imgur.com/BlpRb.png>
<https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard>

## Add executable to apps / dash

```bash
touch ~/.local/share/applications/myapp.desktop
code ~/.local/share/applications/myapp.desktop
```

add text:

```text
[Desktop Entry]
Name=My App
Exec=/full/path/to/myapp
Comment=Launch My App
Terminal=false
Type=Application
Icon=application-x-executable
```
