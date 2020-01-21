{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        bat
        ctags
        exa
        fd
        fzf
        git
        git-extras
        jq
        leiningen
        neovim
        par
        reattach-to-user-namespace
        ripgrep
        taskwarrior
        wget
        yq
      ];
    };

    elasticPackages = pkgs.buildEnv {
      name = "elastic-packages";
      paths = [
        google-cloud-sdk
        kubectl
        minikube
        sshuttle
      ];
    };

    pathsToLink = [ "/share" "/bin" "/Applications" ];
  };
}
