# DevOps Technical Challenge - Python API

This project contains the containerization, orchestration, and CI/CD pipeline solution for the Devsu User API. The solution uses High Availability, Security, and GitOps best practices.

## Infrastructure Architecture

The solution uses Kubernetes to orchestrate the application, ensuring scalability and resilience.

## Technical Decisions and Improvements

To meet production-ready standards, the following architectural decisions were implemented:

1.  Security:
    * The DJANGO_SECRET_KEY was removed from the source code and .env file.
    * A Kubernetes Secret (Opaque) is now used to inject the key at runtime via environment variables.
    * The .gitignore file was updated to prevent accidental commitment of local credentials.

2.  High Availability (Scalability):
    * Horizontal Pod Autoscaler (HPA) was configured to monitor CPU usage.
    * The deployment scales automatically between 2 and 5 replicas when CPU utilization exceeds 50%.
    * Resource requests and limits were defined in the Deployment to ensure node stability and correct HPA metrics.

3.  Networking:
    * A ClusterIP Service combined with an Ingress resource was chosen instead of NodePort. This simulates a real-world production environment where traffic is managed by a Reverse Proxy/Ingress Controller.

4.  CI/CD Pipeline:
    * A GitHub Actions workflow was created to automate:
        * Linting (flake8).
        * Unit Testing with Code Coverage.
        * Docker Image Build and Push to DockerHub.

---

## Deployment Instructions

### Prerequisites
* Docker & Docker Compose
* Kubernetes Cluster (Minikube or Docker Desktop)
* Kubectl CLI

### 1. Automated Deployment (CI Pipeline)
The project includes a GitHub Actions workflow that triggers on every push to the main branch. It automatically checks the code, runs tests, and builds the Docker image.

### 2. Manual Deployment (Local Kubernetes)
To deploy the full infrastructure to your local cluster, apply all manifests:

```bash
kubectl apply -f k8s/app.yml
```

### 3. Verification
Verify that Pods are running and HPA is active:

```bash
kubectl get pods
kubectl get hpa
```

Check the Ingress endpoint (Address/IP):

```bash
kubectl get ingress
```


# Demo Devops Python

This is a simple application to be used in the technical test of DevOps.

## Getting Started

### Prerequisites

- Python 3.11.3

### Installation

Clone this repo.

```bash
git clone https://bitbucket.org/devsu/demo-devops-python.git
```

Install dependencies.

```bash
pip install -r requirements.txt
```

Migrate database

```bash
py manage.py makemigrations
py manage.py migrate
```

### Database

The database is generated as a file in the main path when the project is first run, and its name is `db.sqlite3`.

Consider giving access permissions to the file for proper functioning.

## Usage

To run tests you can use this command.

```bash
py manage.py test
```

To run locally the project you can use this command.

```bash
py manage.py runserver
```

Open http://localhost:8000/api/ with your browser to see the result.

### Features

These services can perform,

#### Create User

To create a user, the endpoint **/api/users/** must be consumed with the following parameters:

```bash
  Method: POST
```

```json
{
    "dni": "dni",
    "name": "name"
}
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "detail": "error"
}
```

#### Get Users

To get all users, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
[
    {
        "id": 1,
        "dni": "dni",
        "name": "name"
    }
]
```

#### Get User

To get an user, the endpoint **/api/users/<id>** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the user id does not exist, we will receive status 404 and the following message:

```json
{
    "detail": "Not found."
}
```

## License

Copyright © 2023 Devsu. All rights reserved.
