{ pkgs }:

let
  pypkgs = pkgs.python3Packages;

  # Dashscope Wheel
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
    propagatedBuildInputs = with pypkgs; [ 
      requests 
      tqdm 
      pydantic 
      cryptography 
      websocket-client 
      aiohttp 
    ];
  };

in
# Qwen-Agent Wheel
pypkgs.buildPythonPackage rec {
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
    python-dateutil
    numpy
    packaging
    python-dotenv
    beautifulsoup4
    httpx
    jsonschema
    nltk
    rank-bm25
    markdown
    jieba
    lxml
    html2text
    pdfminer-six
    openpyxl
    python-docx
    pdfplumber
    sentencepiece
    chardet
    snowballstemmer
    python-magic
    python-pptx      # <--- Fixes the 'pptx' error
  ];

  doCheck = false;
}
