# Node Package Manager

- **nvm** ...used to install/uninstall various NODEJS versions
- **node** ...back-end JavaScript runtime environment (V8 JavaScript Engine)
- **npm** ...package manager

## NPM

### Linux - n

<https://www.npmjs.com/package/n>

```bash
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo n latest
n
```

### Windows - nvm

- Windows
  - <https://community.chocolatey.org/packages/nvm>
  - `choco install nvm`
  - <https://github.com/coreybutler/nvm-windows>

- Linux
  - <https://github.com/nvm-sh/nvm>

- `nvm list`
- `nvm list available`
- `nvm install latest`
- `nvm install lts`
- <https://gist.github.com/chranderson/b0a02781c232f170db634b40c97ff455>

## npm commands

- `npm install -g npm@latest`
- `npm init -y`
- `npm list -g`
- `npm update -g`
- `npm install -g typescript@latest`

### Update Dependecies

- `npm outdated`
- `npm update`
- `npm audit --fix`
- `npm install <package>@latest`
- Reactupdate: `npm install react react-dom @types/react @types/react-dom`

## nodejs project

- `npm init -y`
- `npm i -D typescript ts-node nodemon` and TS global `npm i -g typescript`
- `tsc --init`

### Configure nodemon

- create `nodemon.json` and add stuff

### start & debug

- `npm start`
