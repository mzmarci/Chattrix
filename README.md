# Chattrix     

Chattrix is a messaging used for team messaging, voice calling, screen sharing, file sharing, and workflow automation. Think of it like slack or teams.

## Repo Structure: Frontend, Backend, and Database
Here’s how the repo is organized:

Component Folder	                                                   Description
Frontend (this is webapp)	                   -Built with React and TypeScript. This is the user interface.
Backend	 (this is the server)	               -Written in Go. Handles APIs, authentication, messaging, etc.
Database (this is an External setup)           -Uses PostgreSQL (or optionally MySQL). Stores messages, users, etc.
api                                            – RESTful services

N.B - the Database is configured separately.

## Architecture Overview
Backend: A single Go binary handling API, auth, notifications 

Frontend: React app served via the backend, user-facing UI.

Database: PostgreSQL for main data; optionally Redis for caching 

Storage/Files: Local disk or S3/BLOB for uploads 

## Step 1: Use the Console (Local Setup)
- To get a feel for the app:

- Install Docker and Docker Compose

- Clone the repo:

- git clone https://github.com/mattermost/mattermost.git
- cd mattermost
- cd server
- cd build

- Use Docker to spin up the app:

- docker-compose -f docker-compose.yml up

- N.B - Applications like Chattrix write logs and temporary files. When the disk fills up, Chattrix might crash or misbehave. So the best thing to do while running this appliaction is to increase the volume/storage to like 30GiB upwards.

Confirm connectivity with: This will test if promtail can reach loki.

docker-compose exec promtail sh -c 'nc -zv loki 3100'

## Deploying that application

- I created the VPC,ALB, EC2, EKS CLUSTER, FARGATE, IAM, NODE, SECURITY GROUP using modules 
- on the bastion host, install kubectl, helm 
- created the ec2, opened the necessary ports, used user data to install docker, docker-compose, git, sonaruqube, trivy and helm
- used github actions to create my docker image from my docker compose,ran sonarqube and trivy on it