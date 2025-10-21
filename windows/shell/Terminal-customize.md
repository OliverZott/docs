# setup windows terminal

<https://www.youtube.com/watch?v=VT2L1SXFq9U>
<https://ohmyposh.dev/docs/installation/windows>
<https://ohmyposh.dev/docs/themes>
<https://ohmyposh.dev/docs/installation/customize>
<https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/aliens.omp.json>

## Install ohmyposh

Install oh-my-posh

- `winget install JanDeDobbeleer.OhMyPosh --source winget --scope user --force`
- in case `oh-my-posh` in shell not reckognize: `$env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin"`

## Install fonts

Install font

- `oh-my-posh font install`
- `oh-my-posh font install meslo`

Configure **Terminal** settings!

- in terminal `CTRL + SHIFT + ,` add

  ```shell
  {
    "profiles":
    {
        "defaults":
        {
            "font":
            {
                "face": "MesloLGM Nerd Font"
            }
        }
    }
  }
  ```

- in case, copy fonts from  
  - `C:\Users\<username>\AppData\Local\Microsoft\Windows\Fonts\MesloLGLDZNerdFont-Bold.ttf` to
  - `C:\Windows\Fonts`

Configure **VS Code**

- settings.json
  - `C:\Users\<username>\AppData\Roaming\Code\User\settings.json`
  or Ctrl + Shift + P -> `Preferences: open user settings (json)`
- add lines:
  - `"terminal.integrated.fontFamily": "MesloLGM Nerd Font",`
  - might not be necessary: `"terminal.integrated.defaultProfile.windows": "PowerShell"`

## Configure profiles

- check with `$profile` or open `code $profile`
- `C:\Users\<username>\Documents\PowerShell`
- examples profiles in [ohmyposh_profiles](/windows/shell/ohmyposh_profiles/ )
- or add manually:
  - `oh-my-posh init pwsh | Invoke-Expression`
  - or (old) ``oh-my-posh init pwsh --config "C:\Users\o.zott\AppData\Local\Programs\oh-my-posh\themes\sonicboom_dark.omp.json" | Invoke-Expression``

## Themes

- `C:\Users\<username>\AppData\Local\Programs\oh-my-posh\themes`

- order and hide shells in list (settings.json)
- check alias commands: `alias ls`, `alias dir`
- new fonts:
  - nerdfonts.com -> Cascadia Cove [link](<https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/CascadiaCode.zip>)
  - extract zip and install to windows fonts!
- oh-my-posh [link](https://ohmyposh.dev/docs/installation/windows)
  - winget install JanDeDobbeleer.OhMyPosh -s winget  
