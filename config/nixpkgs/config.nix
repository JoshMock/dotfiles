{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        bat
        ctags
        direnv
        exa
        fd
        fzf
        git
        "git-extras"
        jq
        leiningen
        neovim
        par
        "reattach-to-user-namespace"
        ripgrep
        "source-highlight"
        taskwarrior
        wget
        yq
      ];
      pathsToLink = [ "/share" "/bin" "/Applications" ];
    };

    elasticPackages = pkgs.buildEnv {
      name = "elastic-packages";
      paths = [
        "google-cloud-sdk"
        kubectl
        minikube
        sshuttle
        "terraform-lsp"
        yarn
      ];
      pathsToLink = [ "/share" "/bin" "/Applications" ];
    };
  };
}
