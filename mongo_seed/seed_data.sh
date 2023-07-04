# Copyright (c) Microsoft Corporation and others. Licensed under the MIT license.
# SPDX-License-Identifier: MIT

mongoimport --host clearlydefined_mongo_db --db clearlydefined --collection definitions-trimmed --type json --file definitions/angular.json --jsonArray
mongoimport --host clearlydefined_mongo_db --db clearlydefined --collection definitions-trimmed --type json --file definitions/flyway-maven-plugin.json --jsonArray
mongoimport --host clearlydefined_mongo_db --db clearlydefined --collection definitions-paged --type json --file definitions/angular-paged.json --jsonArray
mongoimport --host clearlydefined_mongo_db --db clearlydefined --collection definitions-paged --type json --file definitions/flyway-maven-plugin-paged.json --jsonArray
mongoimport --host clearlydefined_mongo_db --db clearlydefined --collection curations --type json --file curations/387.json --jsonArray
