{ pkgs, src }:

let
  ps = pkgs.python3Packages;
  entmax = import ./entmax.nix { inherit pkgs; };
in
ps.buildPythonPackage {
  pname = "x-transformers";
  version = "0.25.4";
  inherit src;

  pyproject = true;
  build-system = [ ps.setuptools ps.wheel ];

  propagatedBuildInputs = [
    ps.torch
    ps.einops
    entmax
  ];

  doCheck = false;
}
