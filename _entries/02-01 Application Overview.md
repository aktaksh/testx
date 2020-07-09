---
sectionid: applicationoverview
sectionclass: h2
title: Application Overview
parent-id: gettingstarted
---

### Application Overview

You will be deploying a customer-facing order placement and fulfilment application that is containerized and architected for a microservice implementation.

![Application diagram](media/overview.png)

The application consists of 3 components:

* A public facing Order Capture swagger enabled API
* A public facing frontend
* A MongoDB database

You need to deploy the **Order Capture API** application ([azch/captureorder](https://hub.docker.com/r/azch/captureorder/)). This will require an external endpoint, exposing the API so that it can be accessed on port 80. The application will need to write to the MongoDB instance you deployed earlier.
