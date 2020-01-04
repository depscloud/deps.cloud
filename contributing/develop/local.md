---
layout: contrib
title: Developing Locally
---

Local targets are available for development.
In order to leverage those targets, you will need to install the appropriate tooling.
While most projects are written in Golang, there are a few that will require NodeJS or Ruby.
To help simplify some of the setup, I've included a general guide to managing these versions locally.

## Golang

Install and manage Golang versions using [gvm](https://github.com/moovweb/gvm).

```
$ bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
$ source ${HOME}/.gvm/scripts/gvm
```

Once installation is complete, you should be able to install and use specific versions of Golang.

```
$ gvm install go1.12.4
$ gvm alias create default go1.12.4
$ gvm use default
$ go version
go version go1.12.4 darwin/amd64
$ which go
${HOME}/.gvm/gos/go1.12.4/bin/go
```

## NodeJS

Install and manage NodeJS versions using [nvm](https://github.com/nvm-sh/nvm).

```sh
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
```

Once installation is complete, you'll need to restart your shell to pick up the new environment variables.
Then, you should be able to install and use specific versions of NodeJS.

```
$ nvm install 10.15.3
$ nvm alias default v10.15.3    # all new shells will use 10.15.3
$ nvm use default               # changes node version for the current terminal
$ nvm current                   # verify you're using the right version
v10.15.3
$ which node
${HOME}/.nvm/versions/node/v10.15.3/bin/node
```

## Ruby

Install and manage Ruby versions using [rvm](https://rvm.io/).

```
## OSX
$ brew install gpg2
$ gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

## Linux
$ gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

$ curl -sSL https://get.rvm.io | bash -s stable
```

Once installation is complete, you'll need to restart your shell to pick up the new environment variables.
Then, you should be able to install and use specific versions of Ruby.

```
$ rvm install 2.3.7
$ rvm alias create default 2.3.7
$ rvm use default
$ rvm current
ruby-2.3.7
$ which ruby
${HOME}/.rvm/rubies/ruby-2.3.7/bin/ruby
```
