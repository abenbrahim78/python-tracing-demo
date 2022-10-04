FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9-slim

ENV PATH "/root/.local/bin:$PATH"

RUN apt-get update && apt-get -y install curl

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 - --uninstall && \
          curl -sSL https://install.python-poetry.org | python3 - && \
          ln -s $HOME/.poetry/bin/poetry /usr/bin/poetry && \
          poetry --version && \
          poetry config virtualenvs.create false

WORKDIR /app
COPY poetry.lock pyproject.toml ./

RUN poetry install --no-dev --no-interaction

COPY python_tracing_demo/ ./

ENV PORT=8080
