#!/bin/sh

echo "Checking out modules..."
mvn --non-recursive scm:checkout -Dmodule.name=document-service-client-java

mvn --non-recursive scm:checkout -Dmodule.name=STIXExtractors
cd STIXExtractors
mvn -e clean install -Dmaven.test.skip=true
cd ..

mvn --non-recursive scm:checkout -Dmodule.name=entity-extractor -DscmVersion=master -DscmVersionType=branch
cd entity-extractor
mvn -e clean install -Dmaven.test.skip=true
cd ..

mvn --non-recursive scm:checkout -Dmodule.name=relation-extractor -DscmVersion=master -DscmVersionType=branch
cd relation-extractor
mvn -e clean install -Dmaven.test.skip=true
cd ..

mvn -q --non-recursive scm:checkout -Dmodule.name=graph-db-connection -DscmVersion=master -DscmVersionType=branch
cd graph-db-connection
mvn -e clean install -Dmaven.test.skip=true
cd ..

mvn -q --non-recursive scm:checkout -Dmodule.name=graph-alignment -DscmVersion=master -DscmVersionType=branch
cd graph-alignment
mvn -e clean install -Dmaven.test.skip=true
cd ..


echo "Building rt..."
mvn -e clean install -Dmaven.test.skip=true
cd streaming-processor
mvn -e clean package -Dmaven.test.skip=true
cd ..
