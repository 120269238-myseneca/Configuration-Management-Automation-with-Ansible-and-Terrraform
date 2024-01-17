
# Welcome to My Ansible Assignment
**Author:** Sudeep Saurabh

## Introduction
This Ansible Assignment is designed to automate the deployment and management of a cloud infrastructure, culminating in the setup of an Nginx server on a Kubernetes cluster.

## Prerequisites
- Terraform
- Ansible
- SSH Client
- Access to a cloud provider (AWS, GCP, etc.)

## Setup Instructions

### Step 1: Generate SSH Keys
Navigate to the Terraform directory and generate SSH keys for the bastion host and Kubernetes cluster:

```bash
cd terraform
ssh-keygen -f bastion_host_key
ssh-keygen -f k8s_key
```

### Step 2: Deploy Infrastructure with Terraform
Initialize Terraform and deploy your infrastructure:

```bash
terraform init
terraform validate
terraform apply -auto-approve
```

#### Warning for Multiple Worker Instances
To deploy multiple worker instances, modify the worker count:

```bash
terraform apply --var worker_count=2 -auto-approve
```

### Step 3: Execute Ansible Playbooks
After Terraform has successfully deployed the infrastructure:

1. Navigate to the Ansible directory:
   ```bash
   cd ../Ansible_Final
   ```
   
2. Run the Ansible playbook:
   ```bash
   ansible-playbook -i aws_ec2.yaml Final_playbook.yml
   ```
   **Warning** , if It not running First , please try to run the ansibleplaybook again without having to edit the code 
   **Note:** The first time you connect, confirm the SSH connection by typing `yes` when prompted.

### Step 4: Running Nginx on the Kubernetes Cluster
To deploy Nginx inside the worker instance:

1. SSH into the bastion host (replace `bastion_public_ip` with your bastion's public IP):
   ```bash
   ssh -i bastion_host_key ec2-user@bastion_public_ip
   ```

2. Run the following Kubernetes commands:
   ```bash
   kubectl get nodes
   kubectl create deployment nginx --image=nginx
   kubectl get deployments
   kubectl create service nodeport nginx --tcp=80:80
   ```

3. Access the Nginx service:
   Replace `worker_private_ip` with the private IP of your worker instance, and `port` with the port number shown after executing the 4th command (e.g., `80:32153/TCP` means use port `32153`):
   ```bash
   curl worker_private_ip:port
   ```

---

##  Kubernetes
  

Kubernetes is a modern tool that changes how we manage and deploy software. It's really popular among big companies because it makes things a lot easier and more efficient. To understand Kubernetes, let's compare it with the old way of doing things, which is using monolithic applications.In the past, software was often built as a monolithic application. This means everything, like the website's front end, the database, and the payment system, was all stuck together in one big piece. This method had some big problems:  

1. **Scalability Issues:** When a lot of people visit a website at the same time, like during Christmas sales, it's hard to handle the extra traffic with a monolithic application. If you need more power for just one part, like the website's front end, you still have to upgrade everything, which is not efficient.  

2. **Lack of Flexibility:** In a monolithic application, you have to use the same programming language for everything. This can limit how creative developers can be and can make development slower. 

Kubernetes solves these problems by using microservices. This means breaking the application into smaller parts. Each part, like the front end or the database, works independently in its own container. This method has a lot of benefits: 

 1. **Easier to Manage:** You can change or upgrade each part separately, without affecting the others. 

2.**Saves Money:** You only use resources where you need them, which can save a lot of money. 

3.**More Flexible:** Developers can use different programming languages for different parts, which can lead to better and faster development. 

 In short, Kubernetes makes managing software much simpler and more efficient. It breaks down big applications into smaller parts, making them easier to handle and more flexible. This is a big change from the old way of doing things and helps a lot, especially for big applications. 


## Acknowledgements (Use these source to Help to do Assignment )
 - https://docs.ansible.com/
 - https://www.youtube.com/watch?v=2vMEQ5zs1ko
 - https://www.youtube.com/@TheSudo/playlists
 - https://www.youtube.com/watch?v=QxgJlJgGA0E
 - https://www.jeffgeerling.com/blog/2022/using-ansible-playbook-ssh-bastion-jump-host
 - https://www.cyberciti.biz/faq/linux-unix-ssh-proxycommand-passing-through-one-host-gateway-server/
 
