# LOG8415-project

## Automated static website deployment with 3 step CI/CD on S3 and EC2

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
