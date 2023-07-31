FROM nixos/nix

RUN nix-env -q | grep man-db | xargs nix-env -e

RUN nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
RUN nix-channel --update
RUN nix-shell '<home-manager>' -A install

ADD home.nix /root/.config/home-manager/home.nix

RUN home-manager switch

ENTRYPOINT ["zsh"]
