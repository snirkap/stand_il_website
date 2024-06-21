# stand_il_website
## Here you can see a diagram explaining the project:
<div align="center">
	<img src="https://github.com/snirkap/stand_il_website/assets/120733215/9da967b0-4ef3-4312-a834-ec4cac0c9350">
</div>


## Overview:

Welcome to the repository for the stand.iL website and its RESTful API gateway. This project leverages AWS services to provide a robust and scalable web application infrastructure, managed with Terraform and automated via a CI/CD pipeline using GitHub Actions.

### Project Components:
1. **AWS S3 Bucket:** 
   - Hosts static website content, including HTML files and image assets.
2. **AWS CloudFront:**
   - A CDN that serves the website content globally, improving load times and providing a secure HTTPS endpoint.
3. **AWS Route 53:**
   - Manages DNS records, allowing users to access the website via a friendly DNS name rather than a direct IP address or AWS-generated URL.
4. **Terraform:** 
   - Used to provision and manage the AWS resources in a repeatable and predictable manner.
5. **GitHub Actions:** 
   - Automates the deployment process, including uploading files to S3 and invalidating the CloudFront cache to reflect updates.
6. **API Gateway**:
   - The AWS API Gateway serves as the entry point for the RESTful API, managing HTTP requests and routing them to appropriate Lambda functions based on defined endpoints.

7. **Lambda Functions**:
   - **Name and Phone Collection**:
     - This Lambda function captures data submitted via a web form, specifically user names and phone numbers. Upon receiving a request, it processes the data and stores it in an S3 bucket for future reference.
   - **Button Click Metric**:
     - Responsible for tracking button clicks on the website, this Lambda function receives the name of the clicked button. It increments a CloudWatch metric associated with the respective button, tallying each click with an increment of 1.

8. **Amazon S3**:
   - S3 buckets are utilized for storing data submitted through the web form. The "Name and Phone Collection" Lambda function deposits this data into the designated S3 bucket for storage and retrieval.

9. **Amazon CloudWatch**:
   - CloudWatch is used for monitoring and logging various metrics related to the system's behavior. Metrics are recorded for button clicks, providing insights into user interaction with the website. Additionally, a dashboard is created in CloudWatch to visualize and analyze these metrics over time.

10. **SNS**:
   - SNS (Simple Notification Service) is used to notified me by email every time the user leaves his details.

### Prerequisites:
* AWS Account with access to API Gateway, Lambda Functions, S3, and Amazon CloudWatch
* Terraform installed on your local machine
* Git installed on your local machine
* awscli installed on your local machine

## Setup and Deployment:
### Clone the Repository
First, clone this repository to your local machine to get started with the project.
```
git clone https://github.com/snirkap/stand_il_website.git
cd stand_il_website
```

### Terraform Initialization and Application
Navigate to the Terraform directory within the cloned repository and run the following command to initialize Terraform, allowing it to download necessary providers and modules.
and change this variables:
* s3_bucket_name
* aws_cloudfront_distribution_aliases
* aws_cloudfront_distribution_acm_certificate_arn
* aws_route53_record_zone_id
* aws_route53_record_name
```
cd tf
terraform init
terraform apply
```
### CI/CD Pipeline
The CI/CD pipeline, defined in .github/workflows/main.yml, automates updates. It triggers on changes to HTML files or the images directory, updating the S3 bucket and invalidating CloudFront's cache to ensure the latest version of the site is available.
