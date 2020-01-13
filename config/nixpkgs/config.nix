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
        jq
        leiningen
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
      ];
    };

    pathsToLink = [ "/share" "/bin" "/Applications" ];
  };
}
