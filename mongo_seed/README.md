This is used to populate two Mongo collections in this dev environment.

Currently, anytime there is a change to this docker image, it must be manually pushed to 
the [Clearly Defined Docker Hub](https://hub.docker.com/r/clearlydefined/docker_dev_env_experiment_clearlydefined_mongo_seed)

### To push latest image to Docker Hub
1. Log into docker

   `docker login -u clearlydefined -p <PASSWORD_FROM_KEYVAULT>`

2. Pull latest code from GitHub repo

3. Build and tag image
  
    `docker build -t clearlydefined/docker_dev_env_experiment_clearlydefined_mongo_seed:latest .`

4. Push image to Docker Hub
  
    `docker push clearlydefined/docker_dev_env_experiment_clearlydefined_mongo_seed:latest`
