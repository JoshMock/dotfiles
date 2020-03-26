{
  permittedInsecurePackages = [
    "openssl-1.0.2u"
  ];

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
        par
        "reattach-to-user-namespace"
        ripgrep
        "source-highlight"
        taskwarrior
        tmux
        tmuxinator
        wget
        yq
        zsh
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
        yarn
      ];
      pathsToLink = [ "/share" "/bin" "/Applications" ];
    };
  };
}
