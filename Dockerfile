# syntax=docker/dockerfile:1

# Keep the Python version in sync with .python-version.

# ---- Build stage: resolve and install dependencies into a virtual env ----
FROM python:3.14-slim-bookworm AS builder

# Copy the uv binary from its official image (pin for reproducible builds).
COPY --from=ghcr.io/astral-sh/uv:0.11 /uv /uvx /bin/

# - compile bytecode so container startup is fast
# - copy packages into the venv (works when copied across build stages)
# - install into a predictable, project-local virtual environment
ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PROJECT_ENVIRONMENT=/app/.venv

WORKDIR /app

# Install dependencies first, without the project source, so this layer is
# cached and only rebuilds when pyproject.toml or uv.lock change.
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    uv sync --frozen --no-install-project --no-dev

# Then copy the source and complete the sync.
COPY . /app
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev

# ---- Runtime stage: a clean, minimal image with just the venv + source ----
FROM python:3.14-slim-bookworm AS runtime

# Run as an unprivileged user.
RUN useradd --create-home --uid 1000 app

WORKDIR /app

# Bring over the prepared virtual environment and the application code.
COPY --from=builder --chown=app:app /app/.venv /app/.venv
COPY --from=builder --chown=app:app /app/src /app/src

# Put the venv first on PATH so "python" is the project interpreter.
ENV PATH="/app/.venv/bin:$PATH"

USER app

# Default command — adjust for your app. For a web service, expose a port and
# run your server instead, e.g.:
#   EXPOSE 8000
#   CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
CMD ["python", "-m", "src.main"]
