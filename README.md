# PoC pydantic + FastAPI

This project is just a quick test about how to use pydantic and FastAPI together

## Getting Started

### Install

I recomend you to use a python version management, for example [pyenv](https://github.com/pyenv/pyenv), This project is commanded by [pipenv](https://pipenv.pypa.io/en/latest/) from the standing point of view of the dependency management.

  ```bash
  pip install pipenv
  pipenv install --dev
  ```
### Running the app

  ```bash
  pipenv run app/main.py
  ```

### Configuration

| Property  | Type | Default value |
|-----------|------|---------------|
| HOST      | str  | 0.0.0.0       |
| PORT      | int  | 8000          |

For example, if you want to change the default port, you just need to make something like this:

  ```bash
  PORT=5555 pipenv run app/main.py
  ```

### Docker way

1. Build the app Docker image

```bash
make docker/build
```

2. Run the app container

```bash
make docker/start
```

3. Stop the app container (be careful sometimes your docker engine could has some dangling containers, and you have to delete them)

```bash
make docker/stop
```

Of course you can modify the configuration of the application using the environment variables, for example:

```bash
HOST="127.0.0.1" PORT=5555 make docker/start
```

### Development mode

Having a fresh installation of the depencies in place, this will allow you to play inside the virtual environment

```bash
pipenv shell
```

For a complete reference of the operations availabe just execute:

```bash
make help
```

