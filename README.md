# Threat-model-app
This project is based on Amazon's Threat Composer Tool, an open source tool designed to facilitate threat modeling and improve security assessments. You can explore the tool's dashboard here: [Threat Composer Tool](https://awslabs.github.io/threat-composer/workspaces/default/dashboard)

## Dockerfile
This Docker build process for the AWS Threat Composer tool follows a multi-stage build approach to optimize efficiency. First, we use a Node.js (node:18) container to install dependencies and build the React app into static files. Once built, we switch to a lightweight Nginx (nginx:latest) container, copying only the final optimized files while discarding unnecessary Node.js dependencies. This results in a smaller, more secure, and faster container that serves the application efficiently using Nginx instead of a full Node.js runtime. This setup ensures better performance, reduced resource usage, and improved scalability, making it ideal for production deployment.
## Github CI/CD
For this, what I decided to do was create a separate repo to house modular reusable pipelines so that these can be reused with other projects I decide to dive into in the future. Essentially this consists of creating reusable workflows that can be called by other workflows within a project/repo. 
 
 |Workflow Name | Purpose| Trigger|
 |----|----|----|
 |ci.yml| Linting, Testing, Security Scans| On ```push``` or ```pull_request```|
 |terraform.yml| Deploys infrastrucutre with Terraform| Called after CI completes|
 |build.yml| Builds & pushes Docker images| Called after Terraform|
 |deploy.yml| Deploys the application to AWS ECS/EKS (not sure yet )| Called after Build|

## AWS setup

### AWS IAM configuration
First things first principle of least privilege is highly reccomended for all environments. That means setting up accounts (workloads or human) that are meant to access what they would exactly need to do their jobs. This would also include configuring MFA for those accounts that will be working in the console directly(ie: root account, Admins, Devs, etc..). Read more about AWS security best practices here: [Best Practices] (https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)

In this specific build I'm leveraging AWS Organizations so that I can differentiate my main account that handles all of the billing, and a sub account that has access required for administrative rights paired with MFA. I created a new user and user group paired with MFA that has Administrative rights for deploying the necessary services for this application. Those services include the following:
- this
- is
- temporary
- fo
- now
```yaml
        this is a temp place holder for admin rights policy
```
## Terraform

Links:
- [Managing Terraform State - Best Practices & Examples](https://spacelift.io/blog/terraform-state)
- [Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Recommended Practices](https://developer.hashicorp.com/terraform/cloud-docs/recommended-practices)
- [Module Creation - Best Practices](https://developer.hashicorp.com/terraform/tutorials/modules/pattern-module-creation)
- [Terraform Style - Best Practices](https://developer.hashicorp.com/terraform/language/style)

