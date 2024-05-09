curl -sSL https://install.python-poetry.org | python3 -

poetry install

# This installs and updates pre-commit globally
python3 -m pip install --upgrade pip
pip install --upgrade pre-commit

# To install pre-commit locally, comment out the above and instead run
# poetry add pre-commit
# poetry shell

pre-commit install