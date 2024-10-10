# fms implements a financial model for stock market simulation using OCaml.
# It models the behaviour of a £5,000 investment over 3 years, providing an
# understanding of potential outcomes and risk metrics for both individual
# stocks and the overall portfolio.
#
# Copyright (c) 2024 Finbarrs Oketunji
# Written by Finbarrs Oketunji <f@finbarrs.eu>
#
# This file is part of fms.
#
# fms is an open-source software: you are free to redistribute
# and/or modify it under the terms specified in version 3 of the GNU
# General Public License, as published by the Free Software Foundation.
#
# fms is is made available with the hope that it will be beneficial,
# but it comes with NO WARRANTY whatsoever. This includes, but is not limited
# to, any implied warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE. For more detailed information, please refer to the
# GNU General Public License.
#
# You should have received a copy of the GNU General Public License
# along with fms.  If not, visit <http://www.gnu.org/licenses/>.

# Detect the operating system
UNAME_S := $(shell uname -s)

# Common variables
OCAMLFIND = $(shell opam exec -- which ocamlfind)
OCAMLOPT = ocamlopt
OCAMLFLAGS = -g -w +a-4-42-44-45-48
PACKAGES = unix

# Source files
SRC = fms.ml
INTF = fms.mli
TARGET = fms

# Check if OPAM is initialized
OPAM_INITIALIZED := $(shell if opam var root > /dev/null 2>&1; then echo 1; else echo 0; fi)

all: check-opam install-deps build ## Build all targets

check-opam:
	@if [ $(OPAM_INITIALIZED) -eq 0 ]; then \
		echo "OPAM is not initialized. Initializing OPAM..."; \
		opam init -a -y || (echo "Failed to initialize OPAM. Please initialize manually."; exit 1); \
		eval $$(opam env); \
	fi

install-deps:
	@echo "Checking dependencies..."
ifeq ($(UNAME_S),Darwin)
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Homebrew not found. Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	@echo "Ensuring OCaml and OPAM are installed..."
	brew list ocaml || brew install ocaml
	brew list opam || brew install opam
else
	@echo "Ensuring OCaml and OPAM are installed..."
	sudo apt-get update && sudo apt-get install -y ocaml opam
endif
	@echo "Updating OPAM repositories (this may take a while)..."
	opam update || echo "OPAM update failed, but continuing with build..."
	@echo "Installing required OCaml packages..."
	opam install -y ocamlfind base || (echo "Failed to install required packages. Please install manually."; exit 1)

build: $(INTF) $(SRC) ## Build the Financial Modelling System executable
	@echo "Building with ocamlfind at: $(OCAMLFIND)"
	$(OCAMLFIND) $(OCAMLOPT) -linkpkg -package $(PACKAGES) $(OCAMLFLAGS) -o $(TARGET) $^
	@echo "Build complete. Checking for executable..."
	@if [ -f $(TARGET) ]; then \
		echo "Executable '$(TARGET)' created successfully."; \
		ls -l $(TARGET); \
	else \
		echo "Error: Executable '$(TARGET)' was not created."; \
		exit 1; \
	fi

run: $(TARGET) ## Run the Financial Modelling System
	./$(TARGET)

write-output: $(TARGET) ## Run the simulation and write output to simulation_result.md
	@echo "## Simulation Result" > simulation_result.md
	@./$(TARGET) >> simulation_result.md

clean: ## Clean up build artifacts
	rm -f *.cmi *.cmo *.cmx *.o $(TARGET)

help: ## Display help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: all check-opam install-deps build run write-output clean help

.DEFAULT_GOAL := help
