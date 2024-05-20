import boto3
import json
import os
from datetime import datetime

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    ses = boto3.client('ses')

    bucket_name = event['Records'][0]['s3']['bucket']['name']
    object_key = event['Records'][0]['s3']['object']['key']
    environment = os.environ['environment']

    current_time = datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')

    email_body = f"The Terraform state file for the {environment} environment was modified at {current_time} UTC."

    response = ses.send_email(
        Source=os.environ['SENDER_EMAIL'],
        Destination={
            'ToAddresses': [
                os.environ['RECIPIENT_EMAIL'],
            ],
        },
        Message={
            'Subject': {
                'Data': f'State File Change Detected in {environment.capitalize()} Environment',
                'Charset': 'UTF-8'
            },
            'Body': {
                'Text': {
                    'Data': email_body,
                    'Charset': 'UTF-8'
                }
            }
        }
    )

    return {
        'statusCode': 200,
        'body': 'Email sent successfully!'
    }
