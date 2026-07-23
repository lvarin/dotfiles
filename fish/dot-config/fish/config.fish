source /usr/share/cachyos-fish-config/cachyos-config.fish
if status is-interactive
  set -x EDITOR nvim
  alias less='batcat'
  # Commands to run in interactive sessions can go here
  bind \cr 'history | fzf --tac --query (commandline) | read -l cmd; and commandline --replace "$cmd"'
end



function ssh
    env TERM=xterm ssh $argv
end

function fish_greeting
end
