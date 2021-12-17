# LOG8415-project

## Automated static website deployment with 3 steps CI/CD on S3 and EC2

The goal of this project is to create a setup that will automatically validate and deploy the code from a code repository using a 3 steps pipeline. For the EC2 instances, a SNS service is used to notify the instances of a new build available and they will automatically retrieve the build from S3 and deploy it.

### Prerequisites:
- AWS 
- Python 3 
- A security group configured with port 80 and 5000 open 

### Steps: 
  0. Enter the value of the required fields in the setup.sh file
  1. Run the setup.sh script \
     ```./setup.sh```
  2. Wait a couple minutes for the EC2 instance to launch. The EC2 instance is ready when an html page appears on the public IP/DNS.
  3. Grab the public DNS of the EC2 instance and enter it in the required field of the setup2.sh file
  4. Run the setup2.sh script \
     ```./setup2.sh```
  5. Copy the content of the file add_policy_sns.json and paste it as the new policy of the SNS topic. [Your SNS topic can be accessed here](https://console.aws.amazon.com/sns/v3/home)
  6. Link the SNS topic with the S3 bucket
  7. Create the pipeline following the steps below


### Creation of the pipeline

  1. Visit [CodePipeline](https://console.aws.amazon.com/codesuite/codepipeline/pipelines) and click on create a pipeline
  2. On the first step of the creation, set a name for your pipeline and, in the advanced settings, set a custom location for the artifact store as the artefact S3 bucket. 
  3. For the second step, choose your code repository provider and pair it with your repository.
  4. For the third step, choose AWS CodeBuild as the build provider. 
    - Create a build Project and pair it with the build provider (Don't forget to give S3 permissions to the CodeBuild service role)
  5. For the fourth step, choose Amazon S3 as the deploy provider and select Extract file before deploy.
  6. Congratulations your pipeline is good to run!
