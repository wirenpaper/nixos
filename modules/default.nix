{ lib, ... }:

let
  # This magic code finds all .nix files in this folder (except this one)
  files = builtins.attrNames (builtins.readDir ./.);
  modules = builtins.filter (f: f != "default.nix" && lib.hasSuffix ".nix" f) files;
in
{
  # It automatically creates an import list for all of them
  imports = map (f: ./. + "/${f}") modules;
}
