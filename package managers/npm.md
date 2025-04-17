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
  - <https://github.com/coreybutler/nvm-windows>
  - <https://community.chocolatey.org/packages/nvm>
  - `choco install nvm`

- Linux
  - <https://github.com/nvm-sh/nvm>

- `nvm list`
- `nvm list available`
- `nvm install latest`
- `nvm install lts`
- <https://gist.github.com/chranderson/b0a02781c232f170db634b40c97ff455>

## npm commands

- `npm install -g npm@latest`  ...update npm
- `npm outdated -g`
- `npm update -g`
- `npm install -g typescript@latest`
- `npm list -g`
- `npm init -y`

### Update local Dependecies

- `npm outdated`
- `npm update`
- `npm audit --fix`
- `npm install <package>@latest`
- Reactupdate: `npm install react react-dom @types/react @types/react-dom`

## Useful packages

- [npm-check](https://www.npmjs.com/package/npm-check)
  - `npm install -g npm-check`
  - `npm-check`
- [depcheck](https://www.npmjs.com/package/depcheck)
  - `npm install -g depcheck`
  - `depcheck`

## nodejs project

- `npm init -y`
- `npm i -D typescript ts-node nodemon` and TS global `npm i -g typescript`
- `tsc --init`

### Configure nodemon

- create `nodemon.json` and add stuff

### start & debug

- `npm start`
