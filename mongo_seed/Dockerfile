FROM mongo
RUN mkdir /definitions
COPY ./definitions/* definitions/
CMD mongoimport --host clearlydefined_mongo_db --db clearlydefined --collection definitions-paged --type json --file definitions/definitions.json --jsonArray