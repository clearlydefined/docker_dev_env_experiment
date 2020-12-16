FROM mongo:latest

COPY init.json /init.json
#CMD mongoimport --host clearlydefined_mongo_db --db clearlydefined --collection definitions --drop --file /init.json --jsonArray 
CMD mongoimport --uri mongodb://admin:secret@localhost:27017/clearlydefined --collection definitions --drop --file /init.json --jsonArray 

