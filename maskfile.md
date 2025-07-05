# Tasks for nixos dotfiles :)

## build [system]

> Builds the system and switches to the new config (default laptop)

~~~zsh
if [[ -z "$system" ]]; then
  export system=laptop
fi

echo "Building $system"

sudo nixos-rebuild switch --flake .#laptop
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
