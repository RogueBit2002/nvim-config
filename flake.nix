{
	description = "RogueBit's NeoVim Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		pancake.url = "github:RogueBit2002/pancake.nvim";
	};

	outputs = { self, nixpkgs, pancake, ... }: {
		
		packages = builtins.foldl' (all: system: all // {
			${system} = let
				pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
			in {
				default = pancake.makeNeovimPackage { 
					inherit pkgs;
					luaConfig = ./init.lua;
					label = "lx";
					plugins = with pkgs; [
						vimPlugins.lualine-nvim
						vimPlugins.plenary-nvim
						vimPlugins.nui-nvim
						vimPlugins.nvim-web-devicons
						vimPlugins.neo-tree-nvim
						vimPlugins.nvim-lspconfig
						vimPlugins.sonokai
						vimPlugins.everforest
						vimPlugins.telescope-nvim
						vimPlugins.render-markdown-nvim	
						vimPlugins.vscode-nvim
						vimPlugins.bufferline-nvim
					] ++ [
						# (builtins.fetchGit { url = "https://https://github.com/kubemancer/firewatch.nvim"; rev = "a7a4a32cb1af942c12f69e41100c9298b5dd12ac";})
					];
					nativeDependencies = with pkgs; [ 
						# LSPs
						typescript-language-server
						lua-language-server
						zls
						nil
						tofu-ls
						ripgrep
					];
				};
			};
		}) {} nixpkgs.lib.platforms.all;

		apps = builtins.foldl' (all: system: all // {
			${system} = {
				default = {
					type = "app";
					program = self.packages.${system}.default + /bin/nvim;
				};
			};
		}) {} nixpkgs.lib.platforms.all;
	};
}
