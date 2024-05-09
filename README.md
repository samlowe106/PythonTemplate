# Python Repository Template

This is a template repository for creating Python projects with [poetry](https://python-poetry.org/) and [pre-commit](https://pre-commit.com/) hooks.

## Installation

If you're cloning this repo and want to set it up to work on your machine, you only need to

1. Install poetry
2. Install pre-commit

If you're on a linux machine, this can be done by running setup.sh:

```shell
curl -sSL https://install.python-poetry.org | python3 -
poetry install
python3 -m pip install --upgrade pip
pip install --upgrade pre-commit
pre-commit install
```

From there, you only need to

- edit the repo details in pyproject.toml,
- `poetry add` any additional dependencies,
- customize pre-commit hooks in `.pre-commit-config.yaml`,
- edit the .gitignore file,
- edit this README, and
- set your license

### Creating this repo

The full steps used to create the repo are similar:

```shell
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
```

These commands are in `initialize-project.sh`
