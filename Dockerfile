ARG IMAGE_TAG=3.9.5-alpine3.13@sha256:27c650557ac417c20c4257e669ccd08c1df51966e36e2aab48b83076ea2c2122
FROM python:${IMAGE_TAG} AS builder

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONNUNBUFFERED=1
ENV PYTHONFAULTHANDLER=1

RUN pip install --no-cache-dir pipenv==2021.5.29
WORKDIR /

# Dependencies
COPY Pipfile* ./
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy


FROM python:${IMAGE_TAG} AS runtime

WORKDIR /app

COPY --from=builder /.venv /.venv
ENV PATH="/.venv/bin:$PATH"

ENV HOST="0.0.0.0"
ENV PORT=8000
ENV LOG_LEVEL=info

WORKDIR /app

COPY . ./
ENTRYPOINT [ "python" ]
CMD [ "app/main.py" ]
