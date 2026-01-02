{ pkgs }:

let
  pypkgs = pkgs.python3Packages;

  # Dashscope Wheel (Confirmed)
  dashscope = pypkgs.buildPythonPackage rec {
    pname = "dashscope";
    version = "1.25.5";
    format = "wheel";

    src = pypkgs.fetchPypi {
      inherit pname version;
      format = "wheel";
      dist = "py3";
      python = "py3";
      abi = "none";
      platform = "any";
      sha256 = "sha256-G+nuuvHnMnMXoi25Izdw9CUkY7kmyEBx/9iAWuBs+Zg=";
    };

    propagatedBuildInputs = with pypkgs; [ requests tqdm pydantic ];
  };

  # Qwen-Agent Wheel (Confirmed)
  qwen-agent = pypkgs.buildPythonPackage rec {
    pname = "qwen_agent"; 
    version = "0.0.31";
    format = "wheel";

    src = pypkgs.fetchPypi {
      pname = "qwen_agent"; 
      inherit version;
      format = "wheel";
      dist = "py3";
      python = "py3";
      abi = "none";
      platform = "any";
      sha256 = "sha256-PvgD+EUP3yEcCpWLYjZbF5HJiSjNPzUR0G/rPJflwrM=";
    };

    propagatedBuildInputs = with pypkgs; [
      dashscope
      openai
      pyyaml
      tiktoken
      pydantic
      requests
      json5
      jsonlines
      pillow
    ];
  };

in qwen-agent
