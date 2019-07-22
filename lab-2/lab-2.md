---
layout: default
title: Lab 2 Some other title
---

# 🚀 Lab 2: Microservices with Oracle Database in the cloud

In this lab we will build a small RESTful API with a lightweight [Helidon microservice](https://helidon.io). We will connect the microservice to [Oracle Autonomous Transaction Processing DB](https://www.oracle.com/database/what-is-autonomous-database.html) and deploy our application to Kubernetes.

[Download lab resources](https://m1nka.github.io/autonomous-labs/lab-2/some-zip-file.zip){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 } [View source code](https://github.com/m1nka/autonomous-labs/tree/master/lab-2){: .btn .fs-5 .mb-4 .mb-md-0 }

## Table of contents

* [Prerequisites](#prerequisites)
* [Microservices and Oracle DB](#microservices-and-oracle-db)
* [Lab guide](#lab-guide)
   * [Setting up repository](#setting-up-repository)
   * [Wercker CI/CD pipelines](#wercker-pipelines-for-continous-integration)
   * [Deploying to Kubernetes cluster](#deploying-to-kubernetes-cluster)
   * [Some more steps](#some-more-steps)
* [Next steps](#next-steps)
* [Issues](#issues)


## Prerequisites

- An Oracle Cloud Account to provision a cloud database. You can go to [cloud.oracle.com](https://cloud.oracle.com) and get a 300$ free trial.
- A Kubernetes cluster to deploy the microservice to (e.g. a [managed OKE cluster](https://docs.cloud.oracle.com/iaas/Content/ContEng/Concepts/contengoverview.htm))

## Microservices and Oracle DB

### Introduction to Microservices

Microservices have arguably become one of the most important architectural styles in software engineering. They can enable hyper-scaling, polyglot and fault-tolerant distributed software systems.

If you are not familiar with microservices be sure to check out [Martin Fowler's overview of microservices](https://martinfowler.com/articles/microservices.html). In short, the microservice architectural style is an approach to developing a single application as a suite of small services, each running in its own process and communicating with lightweight mechanisms, often an HTTP resource API. 

![Oracle DB with Microservices](images/monolith-vs-microservices.png)

While independently deployable and scalable microservices can offer significant advantages compared to big monoliths, they may also introduce major challenges (consistancy, managibility, complexity to handle failure, etc).

### How does data management fit in?

Microservices typically prefer letting each service manage its own database, either different instances of the same database technology, or entirely different database systems - an approach called Polyglot Persistence. You can use polyglot persistence in a monolith, but it appears more frequently with microservices.

Such decentralized data management can have considerable downsides and risks:

- Different microservices might require different types of data structures (relational/SQL, non-relational/NoSQL, graph-based, document-based etc.)
- This can lead to a dispursed database landscape with many different technologies (e.g. MySQL, MongoDB, Neo4j etc.)
- The resulting overhead in maintainance, patching and managibility can be huge
- It becomes harder to secure the system as a whole, with many different database technologies involved
- Scalability may be difficult in situations where [eventual consistancy](https://martinfowler.com/articles/microservice-trade-offs.html#consistency) is not acceptable
- Additional considerations like high availabity, back-up strategies have not been made

The process of managing potentially hundreds, or thousands, of individual database instances within Docker containers, can become impractical and costly.

### Taking advantage of a Database-as-a-service layer

In order to solve these issues we can introduce a data management layer, which will mirror the application microservices.

This means that each microservice gets alligned with its own containerized database, that runs in the data management layer.

![Oracle DB with Microservices](images/oracle-db-microservices.png)

With Oracle Autonomous Database as a basis for a data management layer can offer the following advantages:

- No patching overhead, database patches are applied automatically
- The database is designed to secure itself by default. It is serverless and offers no OS or root access for users.
- The autonomous database instance scales elastically up to 128 CPU cores, without any downtime
- Autoscaling can optionally be enabled
- Support for many data structures: Oracle DB supports relational data, JSON, XML, spatial, graph, RDF,  text, binary, object stores, HDFS, Kafka and NoSQL stores


### What is Oracle Autonomous Database?

Oracle Autonomous Database allows you to (almost) instantly create a database that can be elastically scaled from 1-128 CPUs without any downtime. It is fully managed and patches, tunes (auto-indexing) and secures itself without any manual intervention. Optinally, you can enable Autoscaling which will scale the performance of the database (CPU count) automatically.

# Lab guide

## Setting up repository

This is where the tutorial starts with all steps of the lab. Divide the lab into 3-10 chapters. In each chapter describe all steps, including some screenshots.

All lab resources, e.g. CSVs, code, etc. should be included in the repository.

## Wercker pipelines for Continous Integration

Should there be a need to highlight code it can be done like this.

```java

public class GreetService {
  @GET
  @Path("/greet")
  public String getMsg() {
    return "Hello World!";
  }
}

```

## Deploying to Kubernetes cluster

.....

## Some more steps

......

## Next steps

Here we can provide some next steps. We should give ideas what the lab participant can do next with the service. Oracle has lots of good resources (blogs etc.) thank we can link. 


