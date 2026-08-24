# Python Project Template

[![Run Tests](https://github.com/samlowe106/PythonTemplate/actions/workflows/tests.yml/badge.svg)](https://github.com/samlowe106/PythonTemplate/actions/workflows/tests.yml)

A batteries-included starting point for Python projects, wired up with my preferred tooling so a new repo is lint-clean, tested, and CI-ready from the first commit.

## What's inside

- **[uv](https://docs.astral.sh/uv/)** — dependency management, virtual environments, and Python version pinning
- **[pre-commit](https://pre-commit.com/)** hooks — [Ruff](https://docs.astral.sh/ruff/) (lint + autofix), [Black](https://black.readthedocs.io/) (format), [mypy](https://mypy-lang.org/) or [ty](https://github.com/astral-sh/ty) (type-check), [hadolint](https://github.com/hadolint/hadolint) (Dockerfile lint), plus a set of hygiene checks (see [Code quality](#code-quality-pre-commit))
- **[pytest](https://docs.pytest.org/)** with coverage via [pytest-cov](https://pytest-cov.readthedocs.io/)
- **[Docker](https://docs.docker.com/)** — multi-stage Dockerfile + Compose for reproducible, containerized builds
- **[GitHub Actions](https://docs.github.com/en/actions)** — lints, tests, and builds the image on every push and pull request to `main`

## Project layout

```
.
├── .github/workflows/tests.yml   # CI: lint (pre-commit) + test (pytest + coverage)
├── src/                          # your application code
│   └── main.py                   # entry point
├── tests/                        # pytest tests (test_*.py)
│   └── test_main.py
├── .pre-commit-config.yaml       # ruff, black, mypy, hadolint, hygiene hooks
├── .python-version               # pinned Python version (drives CI + uv)
├── Dockerfile                    # multi-stage, uv-based production image
├── compose.yaml                  # Docker Compose for local runs
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
uv run pytest                      # run tests with coverage + per-test timings
uv run pre-commit run --all-files  # run every hook manually
uv add <package>                   # add a runtime dependency
uv add --dev <package>             # add a dev/tooling dependency
```

## Code quality (pre-commit)

Linting, formatting, and type-checking run automatically on every commit via [pre-commit](https://pre-commit.com/). Install the git hook once with `pre-commit install`; run every hook on demand with:

```bash
uv run pre-commit run --all-files
```

The hooks, defined in [.pre-commit-config.yaml](.pre-commit-config.yaml):

- **[Ruff](https://docs.astral.sh/ruff/)** — linter, run with `--fix` so commits auto-apply fixable violations. The enabled rule set lives in `[tool.ruff.lint]` in [pyproject.toml](pyproject.toml), not in the hook, so your editor's Ruff integration enforces exactly the same rules. On top of the defaults it turns on import sorting (`I`, replacing standalone isort), pyupgrade (`UP`), bugbear (`B`), simplify (`SIM`), return hygiene (`RET`), logging (`LOG`/`G`), perflint (`PERF`), and print detection (`T20`).
- **[Black](https://black.readthedocs.io/)** — opinionated code formatter.
- **Type checker** — [mypy](https://mypy-lang.org/) (the mature default) and [ty](https://github.com/astral-sh/ty) (Astral's much faster, pre-1.0 checker) are both enabled. Pick one and delete the other hook; running both is redundant. mypy's settings live in `[tool.mypy]` in [pyproject.toml](pyproject.toml).
- **[hadolint](https://github.com/hadolint/hadolint)** — Dockerfile linter. It runs via Docker, so Docker must be available (or skip it locally with `SKIP=hadolint-docker git commit ...`).
- **Hygiene checks** — trailing whitespace, end-of-file newline, merge-conflict markers, valid JSON/TOML/YAML/XML, `test_*.py` naming, and more.

Because Ruff and mypy read their config from [pyproject.toml](pyproject.toml), the CLI, your editor, and pre-commit all stay in agreement.

> **Heads-up on `T20` (print detection):** Ruff flags leftover `print()` calls, which is great for catching debug statements but will complain about intentional prints (e.g. in a CLI). To allow a specific line, append `# noqa: T201`; to allow them everywhere, remove `"T20"` from `extend-select` in [pyproject.toml](pyproject.toml).

The hook versions are refreshed automatically each month by the [pre-commit-autoupdate](.github/workflows/pre-commit-autoupdate.yml) workflow, which opens a PR when newer versions are available.

## Docker

A multi-stage [Dockerfile](Dockerfile) and [compose.yaml](compose.yaml) are included. The
image installs dependencies from `uv.lock`, runs as a non-root user, and defaults to
`python -m src.main`.

```bash
docker build -t myapp .     # build the image
docker run --rm myapp       # run it
docker compose up --build   # ...or via Compose
```

For a web service, set an `EXPOSE`/port and update the `CMD` in the Dockerfile (and the
ports in compose.yaml). CI builds the image on every push/PR to catch a broken Dockerfile.

## Make it your own

- [ ] Set `name`, `description`, and an author in [pyproject.toml](pyproject.toml)
- [ ] Replace the example code in [src/](src/) and write real tests in [tests/](tests/) (named `test_*.py`)
- [ ] Adjust the pinned version in [.python-version](.python-version) if needed
- [ ] Pick a type checker (mypy or ty) and delete the other hook in [.pre-commit-config.yaml](.pre-commit-config.yaml)
- [ ] Customize the hooks in [.pre-commit-config.yaml](.pre-commit-config.yaml) and the Ruff/mypy rules in [pyproject.toml](pyproject.toml)
- [ ] Edit [.gitignore](.gitignore)
- [ ] Set the `CMD`/ports in [Dockerfile](Dockerfile) and [compose.yaml](compose.yaml) for your app
- [ ] Add your license text to the empty [LICENSE](LICENSE) file
- [ ] Update the CI badge URL and rewrite this README
