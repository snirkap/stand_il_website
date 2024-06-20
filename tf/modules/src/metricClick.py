import boto3

def lambda_handler(event, context):
    # Extract button name from the event
    button_name = event.get('button_name')
    
    if not button_name:
        return {
            'statusCode': 400,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',  # Ensure this matches the headers you're sending
                'Access-Control-Allow-Methods': 'GET,OPTIONS,POST,PUT'
            },
            'body': 'Button name not provided'
        }

    # Increment custom metric in CloudWatch
    cloudwatch = boto3.client('cloudwatch')
    try:
        response = cloudwatch.put_metric_data(
            Namespace='countClickButton',  
            MetricData=[
                {
                    'MetricName': 'ButtonClickedCount',
                    'Dimensions': [
                        {
                            'Name': 'Button',
                            'Value': button_name
                        }
                    ],
                    'Unit': 'Count',
                    'Value': 1  # Increment the value by 1 every time
                }
            ]
        )
        print("Custom metric updated successfully")
    except Exception as e:
        print(f"Error updating custom metric: {e}")
        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*',  
                'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
                'Access-Control-Allow-Methods': 'GET,OPTIONS,POST,PUT'
            },
            'body': 'Error updating custom metric'
        }

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': '*',  
            'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
            'Access-Control-Allow-Methods': 'GET,OPTIONS,POST,PUT'
        },
        'body': f'Metric updated successfully for button: {button_name}'
    }