# My dotfiles

Configure linux workstation using Ansible.

## Base tools
 - wget
 - curl

### System

- git
- tmux
- vim
- zsh

## Bootstrap

You may use the script `./bin/dot-bootstrap` to run ansible. If no parameter is passed it runs all the roles in the localhost. It can also be run for a remote host by doing:

```
$ ./bin/dot-bootsrap 'h1.example.com,'
```

And to run only one of the roles, like 	`vim` for example:

```
$ ./bin/dot-bootstrap 'h1.example.com,' vim
```
