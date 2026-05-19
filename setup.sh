#!/usr/bin/bash

set -euo pipefail

OS="$(uname -s)"

if [[ ! "$OS" == "Linux" && ! "$OS" == "Darwin" ]]; then
    echo "Unsupported OS: $OS" >&2
    exit 1
fi

if ! command -v uv >/dev/null 2>&1; then
    echo "uv not found. Installing..."

    curl -LsSf https://astral.sh/uv/install.sh | sh

    # Add uv to PATH for current shell session
    export PATH="$HOME/.local/bin:$PATH"
else
    echo "verified $(uv --version)"
fi

uv init
uv add pre-commit pytest python-dotenv

# uv add httpx vcrpy pytest-asyncio
# uv add django
# uv add fastapi
# uv add PySide6

touch .env

pre-commit autoupdate
pre-commit install

rm setup.sh
