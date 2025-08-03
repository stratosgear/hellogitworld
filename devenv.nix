{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
in
{
  # https://devenv.sh/basics/
  env.GREET = "WaitNoMore Development Environment";
  # env.LIVEBOOK_HOME = env.DEVENV_ROOT;

  # From: https://github.com/cachix/devenv/blob/python-rewrite/tests/python-native-libs/devenv.nix
  # we must set LD_LIBRARY_PATH by hand without use of the env-venv
  # version of nixpkgs, this can be removed when we switch to one
  # env.LD_LIBRARY_PATH = lib.makeLibraryPath [
  #   pkgs.pythonManylinuxPackages.manylinux2014Package
  #   pkgs.zlib
  # ];

  # https://devenv.sh/packages/
  packages = [
    # pkgs.elixir
    # pkgs.elixir-ls

    # pkgs.inotify-tools
    # pkgs.watchman

    # Want to use 'working-dir' that is available in nixpkgs-unstable only
    pkgs-unstable.just

    # Temporarily disable, since it does not install anymore
    # with: (Mix) Could not compile dependency :iso8601
    # pkgs-unstable.livebook

    # pkgs-unstable.tilt
    # pkgs-unstable.pnpm

    # pkgs.cloudflared

    # added so we can use context7 within VScode
    # pkgs-unstable.nodejs_24

    pkgs-unstable.gg-jj
    pkgs-unstable.jujutsu
    pkgs-unstable.jjui
  ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;
  # languages.elixir.enable = true;
  # languages.erlang.enable = true;
  # languages.javascript.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo ================================================================
    "${pkgs.figlet}/bin/figlet" -f nancyj-fancy Wainomo
    echo ================================================================
    echo Welcome!
  '';
  # node --version

  # export LIVEBOOK_HOME=$DEVENV_ROOT
  enterShell = ''
    export PATH="$HOME/.mix/escripts:$PATH"
    hello
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "echo Project setup";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/

  # See full reference at https://devenv.sh/reference/options/
  # services = {

  #   postgres = {
  #     enable = true;
  #     listen_addresses = "127.0.0.1";
  #     port = 5433;
  #     package = pkgs.postgresql_16;
  #     initialDatabases = [
  #       {
  #         name = "ablekitten";
  #         user = "postgres";
  #         pass = "4blek177ain..";
  #       }
  #     ];
  #     extensions = extensions: [
  #       # extensions.postgis
  #       # extensions.timescaledb
  #     ];
  #     # settings.shared_preload_libraries = "timescaledb";
  #     # initialScript = "CREATE EXTENSION IF NOT EXISTS timescaledb;";
  #     # initialScript = "CREATE ROLE postgres SUPERUSER; CREATE ROLE hello;";
  #   };

  #   redis = {
  #     enable = true;
  #     bind = "127.0.0.1";
  #     port = 16379;
  #   };
  # };

  # processes = {

  #   apiserver.exec = ''
  #     cd src;
  #        uv run python -m debugpy --listen 0.0.0.0:5676 -m apiserver.debug
  #   '';

  # };

}
