{
	description = "RogueBit's NeoVim Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		pancake.url = "github:RogueBit2002/pancake.nvim";
	};

	outputs = { self, nixpkgs, pancake, ... }: let
		
	in {
		
		packages = builtins.foldl' (all: system: all // {
			${system} = let
				pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
			in {
				default = pancake.makeNeovimPackage { 
					inherit pkgs;
					luaConfig = ./init.lua;
					label = "pancake-demo";
					plugins = [
						pkgs.vimPlugins.lualine-nvim
						pkgs.vimPlugins.plenary-nvim
						pkgs.vimPlugins.nui-nvim
						pkgs.vimPlugins.nvim-web-devicons
						pkgs.vimPlugins.neo-tree-nvim
						pkgs.vimPlugins.nvim-lspconfig
						pkgs.vimPlugins.sonokai
						pkgs.vimPlugins.telescope-nvim
					];
					nativeDependencies = with pkgs; [ 
						typescript-language-server
						lua-language-server
						ripgrep
					];
				};
			};
		}) {} nixpkgs.lib.platforms.all;
	};
}