---
sectionid: db
sectionclass: h2
parent-id: devtasks
title: Deploy Database and Create Secrets
---

### Architecture Diagram
Here's a high level diagram of the components you will be deploying during this section (click the picture to enlarge)

<a href="media/architecture/mongo.png" target="_blank"><img src="media/architecture/mongo.png" style="width:500px"></a>

* The **pod** holds the containers that run MongoDB
* The **deployment** manages the pod
* The **service** exposes the pod to the Internet using a public IP address and a specified port

### Tasks

You need to deploy MongoDB in a way that is scalable and production ready.

**Task Hints**

* We will use YAML manifest files to deploy MongoDB, storage and service.
* Be careful with the authentication settings when creating MongoDB. It is recommended that you create a standalone username/password. The username and password can be anything you like, but make a note of them for the next task.

> **Important**: First we will use YAML manifest files to install MongoDB. Then we will create a storage in the form of Persistent Volume Claim (PVC) for the MongoDB to store the data. Lastly we will create a service which will expose connections for MongoDB to accept.

#### Deploy an instance of MongoDB to your cluster

We will use simple YAML manifest files to deploy MongoDB, Storage and Service. We will deploy a single instance of MongoDB which can be replicated and scaled horizontally if required.

**Task Hints**

Create MongoDB Deployment with following details:
* Name of the MongoDB database (defined using environment variable MONGODB_DATABASE) is akschallenge
* Username to connect to MongoDB (defines using environment variable MONGODB_USERNAME) is orders-user
* Password to connect to MongoDB user (defined using environment variable MONGODB_PASSWORD) can be set to anything of your choice. We've defined it as orders-password
* Password to connect to MongoDB as root user (defined using environment variable MONGODB_ROOT_PASSWORD) is root
* We have also defined storage (mongodb-storage) in the form of PersistentVolumeClaim

{% collapsible %}

Save the YAML below as `mongo-deploy.yaml` or download it from [mongo-deploy.yaml](yaml-solutions/01. challenge-02/mongo-deploy.yaml)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    run: mongodb
  name: mongodb
spec:
  replicas: 1
  selector:
    matchLabels:
      run: mongodb
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        run: mongodb
    spec:
      volumes:
      - name: data
        persistentVolumeClaim:
          claimName: mongodb-storage
      securityContext:
        fsGroup: 1001
      containers:
      - env:
        - name: MONGODB_PASSWORD
          value: orders-password
        - name: MONGODB_ROOT_PASSWORD
          value: root
        - name: MONGODB_USERNAME
          value: orders-user
        - name: MONGODB_DATABASE
          value: akschallenge
        image: docker.io/bitnami/mongodb:4.2.4-debian-10-r0
        name: mongodb
        ports:
        - containerPort: 27017
        volumeMounts:
        - name: data
          mountPath: /bitnami/mongodb
```

And create it using

```sh
kubectl apply -f mongo-deploy.yaml
```

{% endcollapsible %}

> **Note** The application expects a database named `akschallenge`. Using a different database name will cause the application to fail!

#### Deploy an Storage for MongoDB

We will create a PersistentVolumeClaim for the MongoDB to store the data.

**Task Hints**

* We've defined the PersistentVolumeClaim with name mongodb-storage when creating the deployment. The MongoDB deployment will look for this specific storage. We will create the storage using YAML manifest for MongoDB to claim.

{% collapsible %}

Save the YAML below as `mongo-storage.yaml` or download it from [mongo-storage.yaml](yaml-solutions/01. challenge-02/mongo-storage.yaml)

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mongodb-storage
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 8Gi
```

And create it using

```sh
kubectl apply -f mongo-storage.yaml
```

{% endcollapsible %}


#### Create service for MongoDB

We will create a Service with name orders-mongo-mongodb for the MongoDB which will expose the database at port 27017 and accept connections.

**Task Hints**

* We've defined the connection port with 27017 when creating the deployment. The MongoDB deployment will be able to accept connections on this port when a service with the specific port is created as a loadBalancer to accept TCP connetions. We will create the service using YAML manifest for MongoDB to connect.

{% collapsible %}

Save the YAML below as `mongo-service.yaml` or download it from [mongo-service.yaml](yaml-solutions/01. challenge-02/mongo-service.yaml)

```yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  name: orders-mongo-mongodb
spec:
  ports:
  - port: 27017
    protocol: TCP
    targetPort: 27017
  selector:
    run: mongodb
status:
  loadBalancer: {}
```

And create it using

```sh
kubectl apply -f mongo-service.yaml
```

{% endcollapsible %}


#### Create a Kubernetes secret to hold the MongoDB details

In the previous step, you installed MongoDB, with a specified username, password and a hostname where the database is accessible. You'll now create a Kubernetes secret called `mongodb` to hold those details, so that you don't need to hard-code them in the YAML files.

**Task Hints**
* A Kubernetes secret can hold several items, indexed by key. The name of the secret isn't critical, but you'll need three keys to store your secret data:
  * `mongoHost`
  * `mongoUser`
  * `mongoPassword`
* The values for the username & password will be those you used with the `helm install` command when deploying MongoDB.
* Run `kubectl create secret generic -h` for help on how to create a secret, clue: use the `--from-literal` parameter to allow you to provide the secret values directly on the command in plain text.
* The value of `mongoHost`, will be dependent on the name of the MongoDB service. The service was created by the Helm chart and will start with the release name you gave. Run `kubectl get service` and you should see it listed, e.g. `orders-mongo-mongodb`
* All services in Kubernetes get DNS names, this is assigned automatically by Kubernetes, there's no need for you to configure it. You can use the short form which is simply the service name, e.g. `orders-mongo-mongodb` or better to use the "fully qualified" form `orders-mongo-mongodb.default.svc.cluster.local`

{% collapsible %}

```sh
kubectl create secret generic mongodb --from-literal=mongoHost="orders-mongo-mongodb.default.svc.cluster.local" --from-literal=mongoUser="orders-user" --from-literal=mongoPassword="orders-password"
```

You'll need to reference this secret when configuring the Order Capture application later on.

{% endcollapsible %}

> **Resources**
> * <https://kubernetes.io/docs/concepts/configuration/secret/>
