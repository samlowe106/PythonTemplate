# Python Project Template

[![Run Tests](https://github.com/samlowe106/PythonTemplate/actions/workflows/tests.yml/badge.svg)](https://github.com/samlowe106/PythonTemplate/actions/workflows/tests.yml)

A batteries-included starting point for Python projects, wired up with my preferred tooling so a new repo is lint-clean, tested, and CI-ready from the first commit.

## What's inside

- **[uv](https://docs.astral.sh/uv/)** — dependency management, virtual environments, and Python version pinning
- **[pre-commit](https://pre-commit.com/)** hooks — [Ruff](https://docs.astral.sh/ruff/) (lint + autofix), [Black](https://black.readthedocs.io/) (format), [mypy](https://mypy-lang.org/) (type-check), plus a set of hygiene checks
- **[pytest](https://docs.pytest.org/)** with coverage via [pytest-cov](https://pytest-cov.readthedocs.io/)
- **[GitHub Actions](https://docs.github.com/en/actions)** — lints and tests on every push and pull request to `main`

## Project layout

```
.
├── .github/workflows/tests.yml   # CI: lint (pre-commit) + test (pytest + coverage)
├── src/                          # your application code
│   ├── main.py                   # entry point
│   └── ui.py                     # example PySide6 window (optional — see below)
├── tests/                        # pytest tests (test_*.py)
│   └── test_main.py
├── .pre-commit-config.yaml       # ruff, black, mypy, and hygiene hooks
├── .python-version               # pinned Python version (drives CI + uv)
├── pyproject.toml                # project metadata + dependencies
└── uv.lock                       # pinned, reproducible lockfile
```

## Getting started

Prerequisite: install [uv](https://docs.astral.sh/uv/getting-started/installation/).

```bash
uv sync             # create .venv and install everything from uv.lock
pre-commit install  # run the hooks automatically on every commit
```

Secrets and configuration go in a `.env` file (git-ignored, loaded automatically via
`python-dotenv`):

```bash
touch .env
```

## Everyday commands

```bash
uv run python -m src.main          # run the app
uv run pytest                      # run tests with coverage
uv run pre-commit run --all-files  # run every hook manually
uv add <package>                   # add a runtime dependency
uv add --dev <package>             # add a dev/tooling dependency
```

> **Using the example GUI?** [src/ui.py](src/ui.py) is a small [PySide6](https://doc.qt.io/qtforpython/) window included for reference. PySide6 is not installed by default — run `uv add pyside6` if you want to use it.

## Make it your own

- [ ] Set `name`, `description`, and an author in [pyproject.toml](pyproject.toml)
- [ ] Replace the example code in [src/](src/) and write real tests in [tests/](tests/) (named `test_*.py`)
- [ ] Adjust the pinned version in [.python-version](.python-version) if needed
- [ ] Customize the hooks in [.pre-commit-config.yaml](.pre-commit-config.yaml)
- [ ] Edit [.gitignore](.gitignore)
- [ ] Add your license text to the empty [LICENSE](LICENSE) file
- [ ] Update the CI badge URL and rewrite this README
