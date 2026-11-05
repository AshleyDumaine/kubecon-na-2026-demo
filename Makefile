PKGS := linode-cli rclone kubectl coreutils jq python3 curl xclip age
BREW_INSTALL := curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
.DEFAULT_GOAL = help

deps-brew:
	@command -v brew >/dev/null 2>&1 || $(BREW_INSTALL);

deps-pkgs:
	@$(foreach pkg,$(PKGS),brew install -y $(pkg);)

# default: help

# main
apps:
	@command ./run.sh apps

clean:
	@command ./run.sh clean

copy:
	@command ./run.sh copy

create:
	@command ./run.sh create

deps:
	@command ./run.sh deps

destroy:
	@command ./run.sh destroy

headlamp:
	@command ./run.sh headlamp

help:
	@command ./run.sh help

info:
	@command ./run.sh info

prod:
	@command ./run.sh prod

reset:
	@command ./run.sh reset

setup:
	@command ./run.sh setup
