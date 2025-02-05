# .NET on Linux

- Install .NET SDK
  - <https://dotnet.microsoft.com/en-us/download#linuxubuntu>
  - [scrippted install](https://learn.microsoft.com/en-us/dotnet/core/install/linux-scripted-manual#scripted-install)
  - `chmod +x ./dotnet-install.sh`
  - `./dotnet-install.sh --channel 9.0`
  - `./dotnet-install.sh --version latest` ...installs latest lts
  - `ls ~/.dotnet/sdk` check instal folder

- Add dotnet to PATH: <https://learn.microsoft.com/en-us/dotnet/core/install/linux-scripted-manual#scripted-install>
  - `source ~/.bashrc`
  - add necessary lines, e.g.:
    - `export PATH=$PATH:/home/olli/.dotnet`
    - `export DOTNET_ROOT=$HOME/.dotnet`
    - `export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools`
  - test: `dotnet --info`

## Maui prerequisites

- java: `sudo apt install openjdk-17-jdk`
  - Choose java version: `sudo update-alternatives --config java`
- worklods: `dotnet workloads install maui-android`
- Andoid SDK: install via Rider
