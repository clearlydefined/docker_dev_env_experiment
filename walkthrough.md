# Clearly Defined Dev Environment Walk Through

Let's walk through creating a Clearly Defined Local Development Environment.

## Pre-reqs
* Docker
* Docker Compose
* Docker Desktop (optional)

## Step 1. Set up your directories

First, create a Clearly Defined directory

```bash
$ mkdir clearly_defined
```

Next, change into that directory:

```bash
$ cd clearly_defined
```

And then, from within your clearly_defined repo, clone each of the three major Clearly Defined repos including:
* [website](https://github.com/clearlydefined/website)
* [service](https://github.com/clearlydefined/service)
* [crawler](https://github.com/clearlydefined/crawler)

```bash
$ git clone https://github.com/clearlydefined/website
$ git clone https://github.com/clearlydefined/service
$ git clone https://github.com/clearlydefined/crawler
```

[NOTE - currently need to check out `nell/dev-docker-file` branch for each of those three repos]

Let's start off by getting the website running.

## Step 2. Set up the Clearly Defined Website

The Clearly Defined website is a React front end to the Clearly Defined service.

Take a look at what is in the website repo, you will see two Dockerfiles

```bash
$ ls website
(...)
DevDockerfile
Dockerfile
(...)
```

Since we are creating a Development environment, we will use the DevDockerFile.

Make sure you are still in your clearly_defined directory:

```bash
$ pwd
/path/to/clearly_defined
```

And create a Docker compose file:

```bash
$ touch docker-compose.yml
```

And open it up in the editor of your choice.

Let's start off by adding some Docker compose boilerplate.

**docker-compose.yml**
```
version: "3.8"
services:
```

And then let's add in just what we need to build and run the website through Docker compose.

**docker-compose.yml**
```
version: "3.8"
services:
  web:
    build:
      context: ./website
      dockerfile: DevDockerfile
    ports:
      - "3000:3000"
    stdin_open: true
```

And if you head to http://localhost:3000 you will see the running Clearly Defined UI!

It looks really nice...but there's not a lot we can do with just the front end of the
service.

Now, let's set up the backend service.

## Step 3. Set up the Clearly Defined service

The Clearly Defined service is an Node JS express application.

It requires some environmental variables to run.

Let's create a .env file to be used by our Docker compose file (NOTE: this is different from the env.json file used in the [historical dev evironment docs](https://docs.clearlydefined.io/contributing-code)).

```bash
touch .env
```

And then add in the minimum environmental variables the service needs to work.

(You will need a [GitHub token](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token) with minimal permissions)

**.env**
```bash
CURATION_GITHUB_TOKEN="<Your GitHub Personal Access Token>"
```

And now let's add the service to our docker-compose file (right under the web service definition)

**docker-compose.yml**
```
version: "3.8"
services:
  web:
    build:
      context: ./website
      dockerfile: DevDockerfile
    ports:
      - "3000:3000"
    stdin_open: true
  service:
    build:
      context: ./service
      dockerfile: DevDockerfile
    env_file: .env
    ports:
      - "4000:4000"
```

And spin the containers back up:

```bash
$ docker-compose up
```

Now, you can both see the UI at http://localhost:3000 AND query the service API at http://localhost:4000

```bash
$ curl http://localhost:4000
```

And this will let you test a bare minimum of Clearly Defined functionality. However, it will be much more useful if we have some data.

## Step 4: Create the Clearly Defined Definitions Database

One of the main things Clearly Defined stores is license definitions for pieces of Open Source Software. If you head to the production deployment of Clearly Defined at https://clearlydefined.io/. you will see several definitions in the "Browse" window.

Let's create the database that will store these definitions.

Let's add it to our Docker Compose file - we will use a MongoDB container.

**docker-compose.yml**
```
version: "3.8"
services:
  web:
    build:
      context: ./website
      dockerfile: DevDockerfile
    ports:
      - "3000:3000"
    stdin_open: true
  service:
    build:
      context: ./service
      dockerfile: DevDockerfile
    env_file: .env
    ports:
      - "4000:4000"
  curations_mongo_db:
    image: "mongo:latest"
    ports:
      - "27017:27017"
    environment:
      - MONGO_INITDB_DATABASE=curations-dev-docker
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=secret 
```

And let's add the appropriate info to the .env file:

**.env**
```bash
CURATION_GITHUB_TOKEN="<Your GitHub Personal Access Token>"

DEFINITION_MONGO_CONNECTION_STRING="mongodb://admin:secret@localhost:27017/definitions-dev-docker"
DEFINITION_STORE_PROVIDER="mongo"
DEFINITION_MONGO_COLLECTION_NAME="definitions-paged"
```

Now let's spin it up with 

```bash
$ docker-compose up
```

Alright, things are working together, but now let's get some data into our definitions database.

