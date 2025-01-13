apt install pipx
pipx ensurepath

pipx install poetry

poetry init
poetry add pre-commit pytest
poetry install

pre-commit autoupdate
pre-commit install
