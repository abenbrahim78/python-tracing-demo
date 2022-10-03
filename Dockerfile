FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9-slim

RUN apt-get update && apt-get -y install curl

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/901bdf0491005f1b3db41947d0d938da6838ecb9/get-poetry.py | python && \
          ln -s $HOME/.poetry/bin/poetry /usr/bin/poetry && \
          poetry --version && \
          poetry config virtualenvs.create false

WORKDIR /app
COPY poetry.lock pyproject.toml ./

RUN poetry install --no-dev --no-interaction

COPY python_tracing_demo/ ./

ENV PORT=8080
