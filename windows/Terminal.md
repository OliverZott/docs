# setup windows terminal

<https://www.youtube.com/watch?v=VT2L1SXFq9U>
<https://ohmyposh.dev/docs/installation/windows>
<https://ohmyposh.dev/docs/themes>
<https://ohmyposh.dev/docs/installation/customize>
<https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/aliens.omp.json>

Profile and Themes in:

- C:\Users\o.zott\Documents\PowerShell
- C:\Users\o.zott\AppData\Local\Programs\oh-my-posh\themes

- order and hide shells in list (settings.json)
- check alias commands: `alias ls`, `alias dir`
- new fonts:
  - nerdfonts.com -> Cascadia Cove [link](<https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/CascadiaCode.zip>)
  - extract zip and install to windows fonts!
- oh-my-posh [link](https://ohmyposh.dev/docs/installation/windows)
  - winget install JanDeDobbeleer.OhMyPosh -s winget  

## Profiles and Themes

- Create PWSH PROFILE
  - `notepad $PROFILE` bzw `echo $PROFILE`
- in `C:\Users\o.zott\Documents\PowerShell\Microsoft.PowerShell_profile.ps1` add line:
  - `oh-my-posh init pwsh --config "C:\Users\o.zott\AppData\Local\Programs\oh-my-posh\themes\sonicboom_dark.omp.json" | Invoke-Expression`

### Alternative

- `Get-PoshThemes` e.g. <https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/aliens.omp.json>
- add each manually --> NOT WORKING CURRENTLY!!
