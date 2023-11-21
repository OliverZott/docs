# ZSH

## Install

**Step 1: Install Zsh**
You can install Zsh on Ubuntu 23.10 by running the following command in your terminal⁵⁴:

```bash
sudo apt install zsh
```

**Step 2: Make Zsh Your Default Shell**
After installing Zsh, you can make it your default shell by running the following command⁴⁹:

```bash
chsh -s /usr/bin/zsh
```

Replace `username` in the command above with your username. Enter the user’s password to confirm the change. Close the terminal and re-open it to access Zsh⁹.

**Step 3: Customize Zsh**
To customize Zsh, you can use the Oh My Zsh framework, which is a collection of scripts and themes that enhance Zsh⁵. You can install it by running the following command⁵:

```bash
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
```

After installing Oh My Zsh, you can change the theme by editing the `ZSH_THEME` property in the `.zshrc` file⁵.

**Step 4: Use Zsh**
Now you can start using Zsh. If you're using GNOME Terminal, you can set Zsh as the default shell for GNOME Terminal only⁶. To do this, open the preferences, go to the configuration profile, select the "Command" tab, tick "Run a custom command instead of my shell" option, and write "zsh" in the "Custom command" textbox⁶.

Source: Conversation with Bing, 11/21/2023
(1) Oh My Zsh! Give Your Linux Terminal a Makeover Using Zsh - DebugPoint.com. <https://www.debugpoint.com/install-use-zsh/>.
(2) How to Install Z Shell(zsh) on Linux? - GeeksforGeeks. <https://www.geeksforgeeks.org/how-to-install-z-shellzsh-on-linux/>.
(3) How To Switch From Bash To ZSH On Linux - AddictiveTips. <https://www.addictivetips.com/ubuntu-linux-tips/switch-from-bash-to-zsh-on-linux/>.
(4) How to set zsh as default for gnome terminal only? - Ask Ubuntu. <https://askubuntu.com/questions/1180222/how-to-set-zsh-as-default-for-gnome-terminal-only>.
(5) Install zsh in ubuntu . <https://tecadmin.net/how-to-install-zsh-on-ubuntu-20-04/>.
(6) . <https://bing.com/search?q=How+to+install+Zsh+on+Ubuntu+23.10>.
(7) 10 Things to Do After Installing Ubuntu 23.10 [With Bonus Tips]. <https://www.debugpoint.com/things-to-do-ubuntu-23-10/>.
(8) . <https://bing.com/search?q=How+to+customize+Zsh+on+Ubuntu+23.10>.
(9) How to Install Grub-Customizer in Ubuntu 23.10 (Updated) to Configure .... <https://fostips.com/grub-customizer-ubuntu-22-10/>.
(10) undefined. <https://askubuntu.com/questions/1032567/install-zsh-in-ubuntu-18-04>.
(11) undefined. <https://askubuntu.com/questions/1347272/how-does-chsh-s-which-zsh-work>.
(12) undefined. <https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh>.
(13) undefined. <https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh%29>.
