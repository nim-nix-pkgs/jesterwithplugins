{
  description = ''A sinatra-like web framework for Nim.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-jesterwithplugins-v0_5_0.flake = false;
  inputs.src-jesterwithplugins-v0_5_0.ref   = "refs/tags/v0.5.0";
  inputs.src-jesterwithplugins-v0_5_0.owner = "JohnAD";
  inputs.src-jesterwithplugins-v0_5_0.repo  = "jesterwithplugins";
  inputs.src-jesterwithplugins-v0_5_0.type  = "github";
  
  inputs."httpbeast".owner = "nim-nix-pkgs";
  inputs."httpbeast".ref   = "master";
  inputs."httpbeast".repo  = "httpbeast";
  inputs."httpbeast".dir   = "v0_4_0";
  inputs."httpbeast".type  = "github";
  inputs."httpbeast".inputs.nixpkgs.follows = "nixpkgs";
  inputs."httpbeast".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/timotheecour/asynctools".owner = "nim-nix-pkgs";
  inputs."github.com/timotheecour/asynctools".ref   = "master";
  inputs."github.com/timotheecour/asynctools".repo  = "github.com/timotheecour/asynctools";
  inputs."github.com/timotheecour/asynctools".dir   = "";
  inputs."github.com/timotheecour/asynctools".type  = "github";
  inputs."github.com/timotheecour/asynctools".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/timotheecour/asynctools".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-jesterwithplugins-v0_5_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-jesterwithplugins-v0_5_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}