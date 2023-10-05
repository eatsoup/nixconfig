{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    sessionVariables = {
      TERM = "xterm-256color";
    };

    initExtra = ''
      bindkey '^ ' autosuggest-accept
      eval "$(direnv hook zsh)"
      unsetopt autocd

      rebase_master() {
        _BRANCH=`git branch --show-current`
        git stash clear
        git stash
        git checkout master
        git pull
        git submodule update --recursive
        git checkout $_BRANCH
        git rebase master
        git stash pop
      }

      kns() {
          if [ -z $1 ]
          then
              _ns=`kubectl get namespace --no-headers | fzf | awk '{ print $1}'`
              kubectl config set-context --current --namespace=$_ns
          else
              _ns=`kubectl get namespace --no-headers | fzf -q $1 | awk '{ print $1}'`
              kubectl config set-context --current --namespace=$_ns
          fi
      }
      ktx() {
          if [ -z $1 ]
          then
              kubectl config use-context `kubectl config get-contexts --no-headers | fzf | awk '{ print $2}'`
          else
              kubectl config use-context `kubectl config get-contexts --no-headers | fzf -q $1 | awk '{ print $2}'`
          fi
      }

      tmux has-session -t vpn > /dev/null 2>&1
      if [ $? != 0 ]
      then
            tmux new-session -s vpn -d
      fi

      alias k=kubectl
      alias force-pull='git reset --hard origin/$(git branch --show-current)'
      alias pbcopy='xclip -sel clip'
      alias jumbovpn="IDLE_TIMEOUT=32400;sudo openconnect -u luukkemp2 --timestamp --disable-ipv6 --no-dtls --protocol fortinet --servercert pin-sha256:ecMX4OoY9h+hQgq7qswgxpnHMMvGj0VSlZLdHNS0vpw= --deflate remoteaccess.jumbo.com/jtc-split -s 'vpn-slice -K 192.168.92.0/24 $(eval echo `cat ~/.jumbo-internal-domains | tr '\n' ' '`)'"
      source <(kubectl completion zsh)

      go-notebook() {
        docker run -it -p 8888:8888 --entrypoint jupyter -v /home/luuk/Documents/notebooks:/notebooks gopherdata/gophernotes  notebook --no-browser --allow-root --ip=0.0.0.0 --notebook-dir=/notebooks --NotebookApp.custom_display_url=http://0.0.0.0:8888
      }

      pr() {
        burl=`git config --get remote.origin.url`
        burl=''${burl//.git/}
        burl=`echo $burl | awk '{gsub(":","/")gsub("git@","https://"); print}'`
        gb=`git branch --show-current`
        pull="pull/new"
        xdg-open $burl/$pull/$gb &>> /dev/null
    }

    export OPENAI_API_KEY=`cat ~/chatgpt.api.key`
    '';

    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "thefuck"
      ];
      theme = "geoffgarside";
    };
  };
}
