{ pkgs, src }:

let
  ps = pkgs.python3Packages;
in
ps.buildPythonPackage {
  pname = "x-transformers";
  version = "latest";
  inherit src;

  pyproject = true;
  # Uses Hatchling to build - standard for modern Lucidrains packages
  build-system = [ ps.hatchling ps.hatch-vcs ];

  propagatedBuildInputs = with ps; [
    torch
    einops
    einx
    loguru
  ];

  doCheck = false;
}
