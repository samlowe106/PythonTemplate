#!/bin/bash

# install uv using one of the following:
# curl -LsSf https://astral.sh/uv/install.sh | sh
# winget install --id=astral-sh.uv  -e

uv init
uv add pre-commit pytest python-dotenv

# add this if you want to use PySide6 for a UI app
#uv add PySide6

touch .env

pre-commit autoupdate
pre-commit install

rm setup.sh
