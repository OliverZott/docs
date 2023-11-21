# .NET on Linux

- Install .NET SDK
  - <https://dotnet.microsoft.com/en-us/download#linuxubuntu>
  - [scrippted install](https://learn.microsoft.com/en-us/dotnet/core/install/linux-scripted-manual#scripted-install)
  - `./dotnet-install.sh --channel 7.0`
  - `./dotnet-install.sh --version latest`

- Add dotnet to PATH: <https://learn.microsoft.com/en-us/dotnet/core/install/linux-scripted-manual#scripted-install>
  - `source ~/.bashrc`
  - add line: `export PATH=$PATH:/home/olli/.dotnet`
  - test: `dotnet --info`
