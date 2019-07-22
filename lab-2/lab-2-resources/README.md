
# Alpha Office PriceService:  Simple Example of Helidon SE service with Oracle Autononous Transaction Processor (ATP) interaction

This example implements a simple price REST service leveraging a product catalog in ATP and 

## Prerequisites

1. Maven 3.5 or newer
2. Java SE 10 or newer
3. Docker 17 or newer to build and run docker images
4. Access to a managed K8S environment, like Oracle Container Engine for Kubernetes (OKE)
5. Kubectl 1.7.4 or newer to deploy to Kubernetes

Verify prerequisites
```
java --version
mvn --version
docker --version
kubectl version --short
```
## Configure Database
Create an ATP instance, download the wallet file, explode the archive, and add a file into the wallet directory
called atp_password.txt with the contents of your ATP password.  See this link for some general guidance:  https://weblogic.cafe/posts/atp-datasource/

You will need to load the product catalog database by using your wallet to login to ATP using a tool like SQLDeveloper.
Using that tool execute the src/main/resources/load_sql_table.sql to load data into the product catalog table

## Configure Code
Examine src/main/java/com/oracle/alphaoffice/priceservice/PriceService.java and make sure all of the properties (ATP_CONNECT_NAME, WALLET_LOCATION, etc) are correct.

## Install Oracle Drivers in local Maven Repo

```
cd $BASEDIR
mvn install:install-file -Dfile=src/main/libs/ojdbc10.jar -DgroupId=com.oracle.jdbc -DartifactId=ojdbc10 -Dversion=19.3.0 -Dpackaging=jar
mvn install:install-file -Dfile=src/main/libs/ucp.jar -DgroupId=com.oracle.jdbc -DartifactId=ucp -Dversion=19.3.0 -Dpackaging=jar
mvn install:install-file -Dfile=src/main/libs/osdt_core.jar -DgroupId=com.oracle.jdbc -DartifactId=osdt_core -Dversion=19.3.0 -Dpackaging=jar
mvn install:install-file -Dfile=src/main/libs/osdt_cert.jar -DgroupId=com.oracle.jdbc -DartifactId=osdt_cert -Dversion=19.3.0 -Dpackaging=jar
mvn install:install-file -Dfile=src/main/libs/oraclepki.jar -DgroupId=com.oracle.jdbc -DartifactId=oraclepki -Dversion=19.3.0 -Dpackaging=jar
```

## Build

```
mvn package
```

## Start the application

```
java -jar target/priceservice.jar
```

## Exercise the application

```
curl -X GET http://localhost:8080/price
{
    Catalog: {
        Products: [
            {
            PRODUCT_ID: 1039,
            .
            .
            .
}

curl -X GET http://localhost:8080/price/1001
{"price":"16.00"}

```

## Build the Docker Image & Tag/Push to Remote 

```
docker build -t priceservice target
docker tag priceservice:latest iad.ocir.io/orasenatdecaentegacpgut02/eshneken_ocir/priceservice:latest  # Replace target tag with your repo!
docker push iad.ocir.io/orasenatdecaentegacpgut02/eshneken_ocir/priceservice                            # Replace target tag with your repo!
```

## Start the application with Docker

```
docker run --rm -p 8080:8080 priceservice:latest
```

Exercise the application as described above

## Deploy the application to Kubernetes

```
kubectl cluster-info                                            # Verify which cluster
kubectl get pods                                                # Verify connectivity to cluster
./src/main/k8s/generate_wallet_secret.sh                        # Upload wallet secret to k8s
kubectl create -f target/app.yaml --namespace=alpha-office      # Deploy application
kubectl get service priceservice                                # Get service info
```
