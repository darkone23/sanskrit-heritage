{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.DEVENV_HTTPD_MODULES = "${pkgs.apacheHttpd}/modules";
  
  # needs old ocaml for Camlp4
  # env.OCAML_TOPLEVEL_PATH = "${pkgs.ocaml-ng.ocamlPackages_4_07.utop}/lib/ocaml";

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.gosu
    pkgs.bash
    pkgs.apacheHttpd 
  ] ++ (with pkgs.ocaml-ng.ocamlPackages_4_07; [
    ocaml
    camlp4
    findlib
    # dune_3
    # utop
    # ocaml-lsp
  ]);

  # https://devenv.sh/languages/
  # languages.ocaml.enable = true;
  # languages.ocaml.packages = pkgs.ocaml-ng.ocamlPackages_4_07;
  languages.javascript.enable = true;
  languages.javascript.npm.enable = true;
  languages.python.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";
  processes.httpd-heritage.exec = ''
    heritage-cgi
  '';

  scripts.heritage-cgi.exec = ''
    sigwinch-hack httpd -d $DEVENV_ROOT/webroot -f conf/httpd.conf -e debug -DFOREGROUND
  '';

  scripts.sigwinch-hack.exec = ''
    setsid --wait $@ &
    child_pid=$!
    trap "kill -SIGINT $child_pid" SIGINT
    wait $child_pid
  '';
  scripts.sigwinch-hack.package = pkgs.bash;
  scripts.sigwinch-hack.binary = "bash";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # # https://devenv.sh/scripts/
  scripts.cp-httpd-conf.exec = ''
    bash -c "cp -r ${pkgs.apacheHttpd}/conf/{magic,mime.types} $DEVENV_ROOT/webroot/conf/"
  '';



  # enterShell = ''
  #   hello
  #   git --version
  # '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  # enterTest = ''
  #   echo "Running tests"
  #   git --version | grep --color=auto "${pkgs.git.version}"
  # '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
