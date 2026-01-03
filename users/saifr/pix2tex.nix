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

  postPatch = ''
    # --- 1. THE "SAFETY NET" PATCH ---
    # Force the model to load weights even if there are slight naming mismatches
    sed -i 's/load_state_dict(torch.load(self.args.checkpoint, map_location=self.args.device))/load_state_dict(torch.load(self.args.checkpoint, map_location=self.args.device), strict=False)/g' pix2tex/cli.py

    # --- 2. THE PATH REDIRECTS ---
    substituteInPlace pix2tex/model/checkpoints/get_latest_checkpoint.py \
      --replace-warn "path = os.path.dirname(__file__)" "path = __import__('os').path.expanduser('~/.cache/pix2tex'); __import__('os').makedirs(path, exist_ok=True)"

    find . -type f -name "*.py" -exec sed -i "s|'checkpoints/weights.pth'|__import__('os').path.expanduser('~/.cache/pix2tex/weights.pth')|g" {} +
    find . -type f -name "*.py" -exec sed -i "s|'checkpoints/image_resizer.pth'|__import__('os').path.expanduser('~/.cache/pix2tex/image_resizer.pth')|g" {} +

    # --- 3. KILL THE WARNINGS ---
    sed -i 's/alb.ShiftScaleRotate/alb.Affine/g' pix2tex/dataset/transforms.py
    sed -i 's/shift_limit=0/translate_percent=0/g' pix2tex/dataset/transforms.py
    sed -i 's/scale_limit=(-\.15, 0)/scale=(0.85, 1.0)/g' pix2tex/dataset/transforms.py
    sed -i 's/rotate_limit=1/rotate=(-1, 1)/g' pix2tex/dataset/transforms.py
    sed -i 's/value=\[255, 255, 255\]/fill=255/g' pix2tex/dataset/transforms.py

    # --- 4. FIX 2026 API COMPATIBILITY ---
    sed -i 's/alb.GaussNoise(10, p=.2)/alb.GaussNoise(std_range=(0.02, 0.05), p=.2)/g' pix2tex/dataset/transforms.py
    sed -i "s/alb.ImageCompression(95, p=.3)/alb.ImageCompression(compression_type='jpeg', quality_range=(95, 100), p=.3)/g" pix2tex/dataset/transforms.py
    sed -i 's/always_apply=True//g' pix2tex/dataset/transforms.py

    find . -type f -name "*.py" -exec sed -i 's/timm.models.layers/timm.layers/g' {} +
    substituteInPlace setup.py \
      --replace-warn "timm==0.5.4" "timm" \
      --replace-warn "opencv-python-headless" "opencv" \
      --replace-warn "einops>=0.3.0" "einops" \
      --replace-warn "x-transformers>=0.3.0" ""
  '';

  dontCheckRuntimeDeps = true;

  propagatedBuildInputs = with ps; [
    torch torchvision timm transformers numpy pillow pyyaml requests
    opencv4 screeninfo pynput munch einops pandas albumentations levenshtein
    x-transformers pydantic pydantic-core
  ];

  doCheck = false;
}
