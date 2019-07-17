---
layout: default
title: Home
nav_order: 1
description: "Just the Docs is a responsive Jekyll theme with built-in search that is easily customizable and hosted on GitHub Pages."
permalink: /
---

# Focus on writing good documentation
{: .fs-9 }

Just the Docs gives your documentation a jumpstart with a responsive Jekyll theme that is easily customizable and hosted on GitHub Pages.
{: .fs-6 .fw-300 }

[Get started now](#getting-started){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 } [View it on GitHub](https://github.com/pmarsceill/just-the-docs){: .btn .fs-5 .mb-4 .mb-md-0 }

---

## Getting started

### Dependencies

Just the Docs is built for [Jekyll](https://jekyllrb.com), a static site generator. View the [quick start guide](https://jekyllrb.com/docs/) for more information. Just the Docs requires no special Jekyll plugins and can run on GitHub Pages' standard Jekyll compiler.

### Quick start: Use as a GitHub Pages remote theme

1. Add Just the Docs to your Jekyll site's `_config.yml` as a [remote theme](https://blog.github.com/2017-11-29-use-any-theme-with-github-pages/)
```yaml
remote_theme: pmarsceill/just-the-docs
```
<small>You must have GitHub Pages enabled on your repo, one or more Markdown files, and a `_config.yml` file. [See an example repository](https://github.com/pmarsceill/jtd-remote)</small>

### Local installation: Use the gem-based theme

1. Install the Ruby Gem
```bash
$ gem install just-the-docs
```
```yaml
# .. or add it to your your Jekyll site’s Gemfile
gem "just-the-docs"
```
2. Add Just the Docs to your Jekyll site’s `_config.yml`
```yaml
theme: "just-the-docs"
```
3. _Optional:_ Initialize search data (creates `search-data.json`)
```bash
$ bundle exec just-the-docs rake search:init
```
3. Run you local Jekyll server
```bash
$ jekyll serve
```
```bash
# .. or if you're using a Gemfile (bundler)
$ bundle exec jekyll serve
```
4. Point your web browser to [http://localhost:4000](http://localhost:4000)

If you're hosting your site on GitHub Pages, [set up GitHub Pages and Jekyll locally](https://help.github.com/en/articles/setting-up-your-github-pages-site-locally-with-jekyll) so that you can more easily work in your development environment.

### Configure Just the Docs

- [See configuration options]({{ site.baseurl }}{% link docs/configuration.md %})

---

## About the project

Just the Docs is &copy; 2017-2019 by [Patrick Marsceill](http://patrickmarsceill.com).

### License

Just the Docs is distributed by an [MIT license](https://github.com/pmarsceill/just-the-docs/tree/master/LICENSE.txt).

### Contributing

When contributing to this repository, please first discuss the change you wish to make via issue,
email, or any other method with the owners of this repository before making a change. Read more about becoming a contributor in [our GitHub repo](https://github.com/pmarsceill/just-the-docs#contributing).

### Code of Conduct

Just the Docs is committed to fostering a welcoming community.

[View our Code of Conduct](https://github.com/pmarsceill/just-the-docs/tree/master/CODE_OF_CONDUCT.md) on our GitHub repository.


# 🚀 Autonomous Labs
[Lab 1: Swingbench and ATP](www.example.com) | [Lab 2: Analytics cloud](www.example.com) | [Lab 3: Low Code With APEX and Autonomous DB](www.example.com) | [Lab 4: Microservices and Autonomous DB](www.example.com) | [Lab 5: Some more labs](www.example.com)

Autonomous Labs are designed to get started instantly with Oracle Autonomous Database. All labs are hands-on and developers will build a small application to built upon.

# Lab 4: Microservices (Helidon) with Oracle Autonomous DB

> First we can provide a very short description with the purpose of the lab, like this: 

In this lab we will build a small RESTful API with a Helidon microservice. We will connect the microservice to Oracle Autonomous Transaction Processing DB and deploy our application to Kubernetes using a CI/CD pipeline.

## Table of contents

> A table of contents which links to each section, like this: 

* [Prerequisites](#prerequisites)
* [Introduction to Microservices](#introduction-to-microservices)
* [Lab guide](#lab-guide)
   * [Setting up repository](#setting-up-repository)
   * [Wercker CI/CD pipelines](#wercker-pipelines-for-continous-integration)
   * [Deploying to Kubernetes cluster](#deploying-to-kubernetes-cluster)
   * [Some more steps](#some-more-steps)
* [Next steps](#next-steps)
* [Issues](#issues)


## Prerequisites

> Here we can write about prerequisites.

- An Oracle Cloud Account
- Right permissions
- This lab will roughly require 200€ in Universal Cloud Credits
- etc.

## Introduction to Microservices

> In this section we do an `Introduction to [topic]`.

Here we can write about the technology and why its cool. E.g. describe what is APEX, with some links and perhaps one or two screenshots. Or why are microservices popular and why should you do it with Helidon and Oracle Managed K8s.

If you want to include an image, the image should be in a folder `/images` and can be shown like this:

![Oracle DB with Microservices](/images/oracle-db-microservices.png)

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

## Issues

If there are issues with this lab guide or you have feedback please tell us in the [issues section](https://github.com/m1nka/autonomous-labs-template/issues) of this repository.




