# Gitlab pipeline examples

.gitlab-ci.yml

## Build and dummy Test pipeline

```bash
stages:
  - build
  - test

variables:
  NODE_ENV: 'development'

before_script:
  - npm install

build:
  stage: build
  script:
    - npm run build
  artifacts:
    paths:
      - dist/

test:
  stage: test
  script:
    - echo "Running dummy tests..."
    - echo "Tests passed!"
```

## Build, Test and Deploy pipeline

.gitlab-ci.yml file

```bash
image: node:14

stages:
  - build
  - test
  - deploy

before_script:
  - npm install -g typescript
  - npm install

build:
  stage: build
  script:
    - tsc

test:
  stage: test
  script:
    - npm test

deploy:
  stage: deploy
  script:
    - tar -czf dist.tar.gz dist package.json
    - scp dist.tar.gz user@production-server:/path/to/deploy/
    - ssh user@production-server 'bash -s' < ./deploy.sh
  only:
    - main

```

Bash script:

```bash
#!/bin/bash
cd /path/to/your/application
tar -xzf /path/to/deploy/dist.tar.gz -C .
npm install --production
pm2 restart all
```

## Using Linter in pipeline

```bash
image: node:14

stages:
  - build
  - lint
  - test
  - deploy

before_script:
  - npm install -g typescript
  - npm install

build:
  stage: build
  script:
    - tsc

lint:
  stage: lint
  script:
    - npx eslint . --ext .ts
  allow_failure: false

test:
  stage: test
  script:
    - npm test

deploy:
  stage: deploy
  script:
    - tar -czf dist.tar.gz dist package.json
    - scp dist.tar.gz user@production-server:/path/to/deploy/
    - ssh user@production-server 'bash -s' < ./deploy.sh
  only:
    - main
  variables:
    POSTGRES_PASSWORD: $POSTGRES_PASSWORD
```

## Using gitlab secrets

```bash
image: node:14

stages:
  - build
  - lint
  - test
  - deploy

before_script:
  - npm install -g typescript
  - npm install

build:
  stage: build
  script:
    - tsc

lint:
  stage: lint
  script:
    - npx eslint . --ext .ts
  allow_failure: false

test:
  stage: test
  script:
    - npm test

deploy:
  stage: deploy
  script:
    - tar -czf dist.tar.gz dist package.json
    - scp dist.tar.gz user@production-server:/path/to/deploy/
    - ssh user@production-server 'bash -s' < ./deploy.sh
  only:
    - main
  variables:
    POSTGRES_PASSWORD: $POSTGRES_PASSWORD
```

Bash script

````bash
#!/bin/bash
cd /path/to/your/application
tar -xzf /path/to/deploy/dist.tar.gz -C .
npm install --production
export POSTGRES_PASSWORD=$POSTGRES_PASSWORD
npm run migrate
pm2 restart all
```
