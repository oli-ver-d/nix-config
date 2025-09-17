# Tasks for nixos dotfiles :)

## build [system]

> Builds the system and switches to the new config (default xps)

~~~zsh
if [[ -z "$system" ]]; then
  export system=xps
fi

echo "Building $system"

sudo nixos-rebuild switch --flake .#$system
~~~

## update

> Update the flake.nix

~~~zsh
nix flake update
~~~

## optimise

> Optimise the nix store by removing duplicate entries and replacing them with a hard-link

~~~zsh
nix-store --optimise
~~~

## gc

> Commit garbage collection, deleting unused stuff from the nix-store and old user profiles

~~~zsh
sudo nix-collect-garbage -d
nix-collect-garbage
~~~

## list

> Lists the systems current nixos generations that are available to boot into!

~~~zsh
sudo nix-env -p /nix/var/nix/profiles/system --list-generations
~~~
