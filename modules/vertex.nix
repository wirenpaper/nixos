{ config, lib, pkgs, ... }:

let
  cfg = config.mySetups.vertex;

  # Define the smart 'rio' wrapper
  rioScript = pkgs.writeShellScriptBin "rio" ''
    export GOOGLE_CLOUD_LOCATION="global"
    
    # --- 1. SETUP PATHS ---
    BASE_DIR="/home/saifr/rnd/Personal_AI_Infrastructure/Packs/pai-neovim-skill/src/skills/NeovimDev"
    BRAIN_FILE="$BASE_DIR/SKILL.md"
    TOOL_SCRIPT="$BASE_DIR/Tools/get-workspace-status.js"

    # --- 2. LOAD BRAIN ---
    if [ -f "$BRAIN_FILE" ]; then
      SYSTEM_PROMPT=$(cat "$BRAIN_FILE")
    else
      SYSTEM_PROMPT="You are a helpful assistant."
    fi

    # --- 3. LOAD TOOLS ---
    if [ -f "$TOOL_SCRIPT" ]; then
      TOOL_OUTPUT=$(${pkgs.nodejs}/bin/node "$TOOL_SCRIPT" 2>/dev/null)
    else
      TOOL_OUTPUT="Tool script not found."
    fi

    # --- 4. PREPARE THE PROMPT ---
    # We add "CONTEXT:" at the start to ensure the string NEVER starts with '-'
    # This fixes the "Not enough arguments following: i" error.
    
    FULL_PROMPT="CONTEXT_START:
    
    $SYSTEM_PROMPT
    
    --- CURRENT STATUS ---
    $TOOL_OUTPUT
    
    --- LOCAL FILES ---
    Location: $(pwd)
    Files: $(ls -F)
    
    USER QUERY: $@"

    # --- 5. RUN GEMINI ---
    # We pass the SAFE prompt to -i
    ${pkgs.gemini-cli}/bin/gemini \
      --model gemini-3-pro-preview \
      -i "$FULL_PROMPT"
  '';
in
{
  options.mySetups.vertex.enable = lib.mkEnableOption "Vertex AI Enterprise setup";

  config = lib.mkIf cfg.enable {
    # 1. Install Google Cloud SDK for authentication
    environment.systemPackages = [ 
      pkgs.google-cloud-sdk 
      pkgs.nodejs # needed to run your js tools
    ];

    home-manager.users.saifr = { ... }: {
      home.packages = [ rioScript ];

      home.sessionVariables = {
	GOOGLE_CLOUD_LOCATION = "global"; 

        # STEP 3: Force Vertex AI Mode
        GOOGLE_GENAI_USE_VERTEXAI = "true";
        GOOGLE_CLOUD_PROJECT = "mustapha-project";
        
        # STEP 1: Clear Old Free-Tier Credentials (The "Clean Slate")
        GEMINI_API_KEY = "";
        GOOGLE_API_KEY = "";
        # Clear our old custom KEY variables too
        KEY1 = "";
        KEY2 = "";
      };

      home.shellAliases = {
        # The primary command (Official Google Agent)
        # We point directly to the binary to avoid any old alias loops
	gemini = "GOOGLE_CLOUD_LOCATION=global ${pkgs.gemini-cli}/bin/gemini --model gemini-3-pro-preview -r latest";
        gemini-new = "GOOGLE_CLOUD_LOCATION=global ${pkgs.gemini-cli}/bin/gemini --model gemini-3-pro-preview";
        gemini-stable = "GOOGLE_CLOUD_LOCATION=global ${pkgs.gemini-cli}/bin/gemini --model gemini-1.5-pro -r latest";
      };
    };
  };
}
