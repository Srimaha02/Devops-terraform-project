# Terraform + Jenkins + Docker on AWS

## 📌 About the Project

This project demonstrates how a simple web application can be **containerized, deployed, and managed using DevOps tools**.

The main goal is to understand how **GitHub, Jenkins, Docker, GHCR, Terraform, and AWS** work together in a real DevOps workflow.

Instead of manually creating AWS resources, Terraform is used to create the infrastructure. Jenkins automates the build and infrastructure provisioning process, while Docker packages the application into a portable container.

---

## 🎯 Why This Project?

In a traditional deployment, we may have to:

- Manually create VPCs, subnets and EC2 instances
- Install Docker on servers
- Build application images manually
- Upload images to a registry
- Repeat the same steps whenever the application changes

This project automates most of these steps using DevOps tools.

The workflow is:

```text
Developer
    ↓
  GitHub
    ↓
  Jenkins
    ├── Build Docker Image
    ├── Push Image to GHCR
    └── Provision AWS using Terraform
              ↓
             AWS
              ↓
        EC2 Instances
              ↓
        Docker Container
              ↓
          Web App

## 🛠️ Technologies & Why They Are Used

- **GitHub** – Stores the source code and manages version control.
- **Jenkins** – Automates the CI/CD pipeline.
- **Docker** – Packages the application into a portable container.
- **GHCR** – Stores and distributes the Docker image.
- **Terraform** – Creates and manages AWS infrastructure using code.
- **AWS EC2** – Provides the servers to run the application.
- **AWS VPC** – Provides an isolated network for the infrastructure.
- **Nginx** – Serves the web application.
- **Git** – Tracks changes in the project.


☁️ AWS Architecture

The project creates a custom VPC with two public subnets in different Availability Zones.

                 AWS VPC
              11.0.0.0/16
                    │
          ┌─────────┴─────────┐
          │                   │
   Public Subnet 1      Public Subnet 2
   11.0.1.0/24          11.0.2.0/24
   us-east-1a           us-east-1b
          │                   │
        EC2-1               EC2-2
          │                   │
     Docker + Nginx      Docker + Nginx
          │                   │
          └─────────┬─────────┘
                    ↓
                Web Browser

Why two subnets and Availability Zones?
The EC2 instances are placed in different Availability Zones to provide basic fault isolation instead of keeping both servers in the same location.

🔄 How the Project Works
1. Code → GitHub
The application code, Dockerfile, Jenkinsfile and Terraform configuration are stored in GitHub.
Git provides version control and GitHub acts as the central repository.

2. GitHub → Jenkins
Jenkins checks out the latest project code and starts the pipeline.

3. Jenkins → Docker
Jenkins builds the application into a Docker image.
index.html
    ↓
Dockerfile
    ↓
Docker Image

This makes the application portable and allows it to run consistently across environments.

4. Docker → GHCR
The generated image is pushed to GitHub Container Registry (GHCR).
Docker Image
     ↓
GHCR
     ↓
ghcr.io/srimaha02/vpc-docker-app

GHCR acts as the central place to store the container image.

5. Jenkins → Terraform → AWS
Jenkins runs Terraform to create the required AWS infrastructure.
Terraform creates:
- VPC
- Internet Gateway
- Public Subnets
- Route Table
- Security Group
- EC2 Instances
This avoids manually creating each AWS resource.

6. EC2 → Docker Container
Docker is installed automatically on the EC2 instances using user_data.sh.
The application image can then be pulled from GHCR and run as a container.

EC2
 ↓
Docker
 ↓
GHCR Image
 ↓
Nginx Container
 ↓
Port 80
 ↓
Web Browser

📂 Project Structure

Devops-terraform-project/
└── app/
    ├── Dockerfile
    ├── Jenkinsfile
    ├── index.html
    │
    └── terraform/
        ├── provider.tf
        ├── vpc.tf
        ├── igw.tf
        ├── subnet.tf
        ├── route_table.tf
        ├── sg.tf
        ├── ec2.tf
        ├── user_data.sh
        └── outputs.tf

Terraform Files

 Each Terraform file has a specific responsibility:
- provider.tf → AWS provider and region
- vpc.tf → Creates the VPC
- igw.tf → Creates Internet Gateway
- subnet.tf → Creates the two public subnets
- route_table.tf → Provides internet routing
- sg.tf → Controls SSH and HTTP access
- ec2.tf → Creates the EC2 instances
- user_data.sh → Installs and starts Docker
- outputs.tf → Displays useful resource IDs and public IPs

🔄 Jenkins Pipeline

The Jenkins pipeline is defined in Jenkinsfile.

Checkout
   ↓
Docker Build
   ↓
Push to GHCR
   ↓
Terraform Init
   ↓
Terraform Apply
   ↓
Show Terraform Output

This allows the Docker image creation and AWS infrastructure provisioning to be performed consistently through Jenkins.

🌐 Application
The application is a simple Nginx web page.
After the container is running:
docker run -d --name vpc-app -p 80:80 \
ghcr.io/srimaha02/vpc-docker-app:latest

The application can be accessed using:
http://<EC2-PUBLIC-IP>

🔐 Security
The EC2 Security Group allows:
- 22 → SSH access
- 80 → HTTP access
Secrets such as AWS credentials and GitHub tokens are stored in Jenkins credentials rather than committed to the repository.

⚠️ Current Scope
The current Jenkins pipeline automates:
Docker image build → GHCR push → Terraform infrastructure provisioning.
The final Docker container deployment on the EC2 instances was performed separately.

👩‍💻 Author
Srimahalakshmi R
B.Tech Information Technology
St. Joseph's Institute of Technology
