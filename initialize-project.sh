# This is the shell file you should run if you've just cloned the TEMPLATE and are initializing a new project for the first time. If you are cloning an existing project, use the setup.sh script instead


curl -sSL https://install.python-poetry.org | python3 -
poetry init
poetry config virtualenvs.in-project true
poetry install

# This installs and updates pre-commit globally
python3 -m pip install --upgrade pip
pip install --upgrade pre-commit

# To install pre-commit locally, comment out the above and instead run
# poetry add pre-commit
# poetry shell

pre-commit install