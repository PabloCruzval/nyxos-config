{lib, config, pkgs, ...}:

{
	options = {
		zsh.enable = lib.mkEnableOption "enable zsh module";
	};

	config = lib.mkIf config.zsh.enable {
		programs.zsh = {
			enable = true;
			enableCompletion = true;
			autosuggestion.enable = true;
			syntaxHighlighting.enable = true;
			
			# History configuration
			history = {
				size = 5000;
				save = 5000;
				path = "${config.home.homeDirectory}/.zsh_history";
				ignoreDups = true;
				share = true;
				ignoreSpace = true;
			};

			# Oh My Zsh configuration
			oh-my-zsh = {
				enable = true;
				plugins = [
					"git"
					"sudo"
					"command-not-found"
				];
			};

			# Plugins using Home Manager's zsh plugin system
			plugins = [
				{
					name = "powerlevel10k";
					src = pkgs.zsh-powerlevel10k;
					file = "share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme";
				}
				{
					name = "fzf-tab";
					src = pkgs.fetchFromGitHub {
						owner = "Aloxaf";
						repo = "fzf-tab";
						rev = "v1.1.2";
						sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
					};
				}
			];

			# Shell aliases
			shellAliases = {
				apagar = "shutdown 0";
				nv = "nvim";
				ls = "ls -l --color";
				py = "python";
			};

			# Environment variables
			sessionVariables = {
				BUN_INSTALL = "$HOME/.bun";
				PNPM_HOME = "/home/nyx/.local/share/pnpm";
			};

			# PATH additions
			localVariables = {
				PATH = [
					"/home/nyx/.cargo/bin"
					"$BUN_INSTALL/bin"
					"$PNPM_HOME"
					"$PATH"
				];
			};

			# Custom initialization code
			initExtra = ''
				# Enable Powerlevel10k instant prompt
				if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
					source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
				fi

				# Custom function
				clipcat(){
					cat "$1" | xclip -selection clipboard
				}

				# Completion styling
				zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
				zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
				zstyle ':completion:*' menu no
				zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
				zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

				# Load p10k config
				[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

				# Initialize fzf and zoxide
				eval "$(fzf --zsh)"
				eval "$(zoxide init --cmd cd zsh)"

				# bun completions
				[ -s "/home/nyx/.bun/_bun" ] && source "/home/nyx/.bun/_bun"

				# pnpm path setup
				case ":$PATH:" in
					*":$PNPM_HOME:"*) ;;
					*) export PATH="$PNPM_HOME:$PATH" ;;
				esac
			'';
		};

		# Install necessary packages
		home.packages = with pkgs; [
			fzf
			zoxide
			xclip
		];
	};
}
