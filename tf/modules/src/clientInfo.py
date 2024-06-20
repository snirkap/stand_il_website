import json
import time
import boto3
import uuid

# Initialize SNS client
sns = boto3.client('sns')

# Initialize S3 client
s3 = boto3.client('s3')

# Email address to receive notifications
email_address = 'snirwork1@gmail.com'

def lambda_handler(event, context):
    try:
        body = json.loads(event['body'])
        name = body['name']
        phone_number = body['phoneNumber']

        # Your S3 bucket name
        bucket_name = 'client-info-stand-il'

        # Create a unique key for each submission, you can use UUID or any other method
        key = f"{int(time.time())}-{uuid.uuid4()}.json"

        # Upload data to S3
        s3.put_object(
            Bucket=bucket_name,
            Key=key,
            Body=json.dumps({'name': name, 'phoneNumber': phone_number}),
            ContentType='application/json'
        )

        # Send notification email
        sns.publish(
            TopicArn='arn:aws:sns:us-east-1:064195113262:MyLambdaNotificationTopic',
            Subject='Lambda Notification',
            Message=f'Lambda function has been triggered. Data stored for {name} with phone number {phone_number}.'
        )

        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',  
                'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
                'Access-Control-Allow-Methods': 'GET,OPTIONS,POST,PUT'
            },
            'body': json.dumps({'message': 'Data successfully stored in S3 and notification sent'})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
