FROM mongo
COPY definitions.json /definitions.json
CMD mongoimport --host clearlydefined_mongo_db --db clearlydefined --collection definitions-paged --type json --file /definitions.json --jsonArray