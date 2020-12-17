FROM mongo
COPY definitions.json /definitions.json
CMD mongoimport --host clearlydefined_mongo_db --db clearlydefined --collection definitions --type json --file /definitions.json --jsonArray