{ pkgs }:

let
  ps = pkgs.python3Packages;
in
ps.buildPythonPackage rec {
  pname = "entmax";
  version = "1.3";
  format = "wheel";

  src = ps.fetchPypi {
    inherit pname version;
    format = "wheel";
    dist = "py3";
    python = "py3";
    abi = "none";
    platform = "any";
    hash = "sha256-Qbse29SXobU7Hw/IC+/VQ0mdxwS05UNt32xXKKLQBUY=";
  };

  # THE FIX: Tell Nix not to try and build the wheel 
  # and provide ninja if a setup hook asks for it.
  nativeBuildInputs = [ pkgs.ninja ];
  dontBuild = true;

  propagatedBuildInputs = [ ps.torch ];
  doCheck = false;
}
