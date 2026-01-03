{ pkgs, src, x-transformers }:

let
  ps = pkgs.python3Packages;
in
ps.buildPythonPackage {
  pname = "pix2tex";
  version = "0.1.4";
  inherit src;

  pyproject = true;
  build-system = [ ps.setuptools ps.wheel ];

  # Fixes the "timm==0.5.4" and "opencv-headless" errors by editing source directly
  postPatch = ''
    substituteInPlace setup.py \
      --replace-warn "timm==0.5.4" "timm" \
      --replace-warn "opencv-python-headless" "opencv"
  '';

  # Crucial: ignore the metadata check so our custom packages link properly
  dontCheckRuntimeDeps = true;

  propagatedBuildInputs = with ps; [
    torch
    torchvision
    timm
    transformers
    numpy
    pillow
    pyyaml
    requests
    opencv4
    screeninfo
    pynput
    munch
    einops
    pandas
    albumentations
    levenshtein
    x-transformers # <--- NOW it's inside the package
  ];

  doCheck = false;
}
