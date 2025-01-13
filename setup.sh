sudo apt install pipx
pipx install poetry

poetry init
poetry add pre-commit
poetry install

pre-commit autoupdate
pre-commit install
