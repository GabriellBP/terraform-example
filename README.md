<p align="center">
    <img width="25%" src="https://github.com/GabriellBP/terraform-example/blob/main/assets/terraform.png"> 
</p>

<h2 align="center">
  Simple Terraform Example
</h2>

<p><b>Terraform</b> is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp. It allows you to define and provision infrastructure resources, such as servers, databases, and networking components, using a high-level configuration language (HCL). Terraform can manage infrastructure across various cloud providers (like AWS, Azure, and Google Cloud) as well as on-premises environments, making it a versatile tool for automating infrastructure management.

With Terraform, you can version your infrastructure, easily replicate environments, and use a declarative approach to define the desired state of your infrastructure, which Terraform then creates and maintains.</p>

## Step by Step

1. Install [Terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform)
2. Install [Docker](https://docs.docker.com/engine/install/)
3. Create [Docker Hub account](https://hub.docker.com/)
4. Create an [AWS account](https://aws.amazon.com/)
5. Download [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
6. Clone the project e.g. `https://github.com/GabriellBP/terraform-example.git`
7. Create Docker Image and publish it to the Docker Hub:
   - Go to `terraform-example/app/`
   - Run the command: `./mvnw install`
   - Update the Dockerfile if necessary with a different Java version and a different jar name (line 3: target/app-0.0.1-SNAPSHOT.jar)
   - Run the command: `docker build -t <your-docker-hub-username>/terraform-example:latest --push .`
        - Or use the following command to build the image for more than one platform (arm and amd in this case): `docker buildx build --platform linux/amd64,linux/arm64 -t <your-docker-hub-username>/terraform-example:latest --push .`
        - M1/M2 has arm based while the linux is amd based, depending on your system and the system of the AWS machine, maybe you need to build the image for more than one platform
        - To run the previous command you need to enable the [docker contained image store](https://docs.docker.com/desktop/containerd/#enable-the-containerd-image-store)
    - You can check the image on your docker hub account or run the command: `docker run -p 8080:8080 <your-docker-hub-username>/terraform-example:latest` and see if the api is working properly: `curl localhost:8080`
8. Grant programmatic access
   - Go to you AWS Account and create an AWS User in the IAM (Identity and Access Management) dashboard
   - I added an Administrator Access policy for this example although it is not recommended, to make it easier - _If you create an Administrator with full access rights, remember to delete it after you run this example_
   - Save the access keys
9. Connect local AWS CLI with remote AWS Account
   - On your local run the command: `aws configure`
   - Fill the fields with your recent user access keys
10. Open the file `terraform-example/infra/start_docker.sh` and replace `gabriellbp/terraform-example` with your docker hub image `<your-docker-hub-username>/terraform-example`
11. Run the command `terraform init` (inside the folder `terraform-example/infra/`) 
12. Run the command `terraform plan` and check all changes that will be applied to your infra
13. Run the command `terraform apply` and write yes to confirm
    - if you get an error about the resource `keypai` you can delete it from the `terraform-example/infra/main.tf` file or jump to step 15 (configure you ssh access) before apply the terraform changes and create your infra
14. Check the ec2 instance created in your AWS account under the [instances page](https://us-east-2.console.aws.amazon.com/ec2/home?region=us-east-2#Instances:v=3;$case=tags:true%5C,client:false;$regex=tags:false%5C,client:false)
15. Click in the created instance to see more details, copy the public ipv4 DNS in your browser or execute the command `curl <your-public-ipv4-DNS` to see the message: *Hello Terraform!*
    - Rembember to use `http` and not `https`
16. To Configure your SSH Access (Optional):
    -  Run the command `ssh-keygen` (check [this](https://phoenixnap.com/kb/generate-ssh-key-windows-10) for windows systems)
    -  Open the file `terraform-example/infra/main.tf` and replace in the line 33 the command `file("~/.ssh/id_ed25519.pub")` using your public key address
    -  run the command `terraform apply`
    -  You can check the key  pair created on your Amazon Clound account under the page `Key Pairs`
    -  To access the remote machine you can run the command `ssh ec2-user@<your-public-ipv4-DNS>`
17. To clean your environment and destroy your infra you can simply run the command `terraform destroy` under the `terraform-example/infra/` folder
    - Confirm everything and then write yes in the command line
   

## Technologies
* Terraform
* Docker
* Java
* Spring
* AWS
* AWS EC2
* SSH access
 
