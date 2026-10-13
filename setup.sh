#!/usr/bin/env bash
set -euo pipefail

config=".ddev/config.local.yaml"

if [[ ! -f .ddev/config.yaml ]]; then
  echo "Run this script from the project root (missing .ddev/config.yaml)." >&2
  exit 1
fi

while true; do
  read -r -p "Create the project with Symfony framework? [y/N] " answer
  case "${answer,,}" in
    y|yes)
      if [[ -e composer.json || -e bin/console ]]; then
        echo "A Composer project already exists here; skipping Symfony creation." >&2
        exit 1
      fi
      if ! command -v symfony >/dev/null 2>&1; then
        echo "Symfony CLI is required. Install it, then run ./setup.sh again." >&2
        exit 1
      fi
      # Generate into a temporary directory because Symfony CLI expects a new path.
      temp_dir="$(mktemp -d "${TMPDIR:-/tmp}/greenfield-symfony.XXXXXX")"
      trap 'rm -rf "$temp_dir"' EXIT
      symfony new "$temp_dir/project" --webapp
      cp -R "$temp_dir/project"/. .
      rm -rf "$temp_dir"
      trap - EXIT
      sed -i.bak 's/^docroot: \.$/docroot: public/' .ddev/config.yaml
      rm -f .ddev/config.yaml.bak
      break
      ;;
    ""|n|no)
      break
      ;;
    *)
      echo "Please answer y or n."
      ;;
  esac
done

while true; do
  read -r -p "Does this project need a database container? [Y/n] " answer
  case "${answer,,}" in
    ""|y|yes)
      cat > "$config" <<'YAML'
omit_containers: []
YAML
      break
      ;;
    n|no)
      cat > "$config" <<'YAML'
omit_containers:
  - db
YAML
      break
      ;;
    *)
      echo "Please answer y or n."
      ;;
  esac
done

ddev start

while true; do
  read -r -p "Delete setup.sh now? [y/N] " answer
  case "${answer,,}" in
    y|yes)
      rm -- "$0"
      echo "Removed setup.sh."
      break
      ;;
    ""|n|no)
      break
      ;;
    *)
      echo "Please answer y or n."
      ;;
  esac
done
