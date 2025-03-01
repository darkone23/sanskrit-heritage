#!/usr/bin/env bash

# bootstrap the user that will eventually run 'devenv shell'
# devenv takes care of compiling the binaries and running the httpd server

# if you are using nixos (recommended) you may be wanting to add the user to nix trusted-users
# https://nix.dev/manual/nix/2.24/command-ref/conf-file.html#conf-trusted-users
#
# please be aware of the security implications of a superuser account
# 
#   users.users.heritage = {
#     isNormalUser  = true; # we will login to this user for now
#     home  = "/var/lib/heritage";
#     extraGroups  = [ "heritage" "wheel" "networkmanager" ];
#  };
#
#  security.sudo.extraRules = [
#    {
#      users = [ "heritage" ];
#      commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
#    }
#  ];
# 
#  nix.settings.trusted-users = [
#    "root"
#    "heritage"
#  ];
#
# 

# gist of steps required for custom non-root user
sudo useradd -m -s /bin/sh -d /var/lib/heritage heritage
sudo groupadd heritage
sudo usermod -aG heritage heritage

sudo chown -R heritage:heritage $DEVENV_ROOT
