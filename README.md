# docker_dev_env_experiment

Hello everyone! The purpose of this repo is to give you an easy way to run a full 
development environment for Clearly Defined including:
* [website](https://github.com/clearlydefined/website)
* [service](https://github.com/clearlydefined/service)
* [crawler](https://github.com/clearlydefined/crawler)
* definitions and curations mongo DB databases
* queues

We do this through running the various services in Docker.

We do this through [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)

## Pre-reqs
To run this environment, you need to install
* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)

## Getting Started

Start off by cloning this repository.

```bash
$ git clone https://github.com/clearlydefined/docker_dev_env_experiment
```

Change into that directory:

```bash
$ cd docker_dev_env_experiment
```

I prefer to clone my copies of the ClearlyDefined repos into this directory as well

```bash
$ git clone https://github.com/clearlydefined/website
$ git clone https://github.com/clearlydefined/service
$ git clone https://github.com/clearlydefined/crawler
```

Alternately, you can edit the **docker-compose.yml** file to point to where you have those repos cloned on your local system:

**docker-compose.yml**
```bash
version: "3.8"
services:
  web:
    build:
      context: <path-to-website-repo-on-your-system>
      dockerfile: DevDockerfile
    ports: 
      - "3000:3000"
    stdin_open: true
  service:
    build:
      context: <path-to-service-repo-on-your-system>
      dockerfile: DevDockerfile
    ports:
      - "4000:4000"
    env_file: .env
    links:
      - clearlydefined_mongo_db
  crawler:
    context: <path-to-crawler-repo-on-your-system>
    env_file: .env
    ports:
      - "5000:5000"
```

**NOTE**:
While this is still in development, you need to check out the `nell/dev-docker-file` branch for each of the
three repos.

### Setting up environmental variables

This environment handles environmental variables a little differently from the [historical Clearly Defined dev environment instructions](https://docs.clearlydefined.io/contributing-code).

The docker-compose.yml file loads environmental variables from a **.env** file.

To set this up, copy the **sample_env** file in this repo to **.env**

```bash
$ cp sample_env .env
```

And add in appropriate values to the .env file:

(You will need a [GitHub token](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token) with minimal permissions)

(You can use the same GitHub token for both CURATION_GITHUB_TOKEN and CRAWLER_GITHUB_TOKEN)


**.env**
```
# Curation GitHub Info
CURATION_GITHUB_REPO="sample-curated-data"
CURATION_GITHUB_BRANCH="master"
CURATION_GITHUB_OWNER="clearlydefined"
CURATION_GITHUB_REPO="curated-data-dev"
CURATION_GITHUB_TOKEN="<Your GitHub Personal Access Token>

DEFINITION_STORE_PROVIDER="mongo"
DEFINITION_MONGO_CONNECTION_STRING="mongodb://clearlydefined_mongo_db"
DEFINITION_MONGO_DB_NAME="clearlydefined"
DEFINITION_MONGO_COLLECTION_NAME="definitions-paged"

CRAWLER_GITHUB_TOKEN="<Your GitHub Personal Access Token>"
```

Now, from withing your **docker_dev_env_experiment** directory, run:

```bash
$ docker-compose build
$ docker-compose up
```

And head to http://localhost:3000 to see your running website UI along with some seeded data!

You can also query the service API with:

```bash
curl http://localhost:4000
```

## What You're Running

Now, let's go through what your are running, container by container.