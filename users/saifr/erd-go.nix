{ pkgs }:

pkgs.buildGoModule rec {
  pname = "erd-go";
  version = "2.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "kaishuu0123";
    repo = "erd-go";
    rev = "v${version}";
    # This hash was confirmed by your first build error
    hash = "sha256-GETgRNJ2UxXyYuCWgEKt0uwquqyg16ropsM+bpiB1Ms="; 
  };

  # This hash was confirmed by your second build error
  vendorHash = "sha256-1nXGzIiCfnsNpCKTxGmCgcUKJwRrEEZdxIbHRV/zYL4=";

  subPackages = [ "." ];

  meta = with pkgs.lib; {
    description = "Relational Entity-Relationship Diagram generator written in Go";
    homepage = "https://github.com/kaishuu0123/erd-go";
    license = licenses.mit;
    mainProgram = "erd-go";
  };
}
