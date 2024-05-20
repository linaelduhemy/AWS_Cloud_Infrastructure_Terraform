data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function_compressed.zip"
}

resource "aws_lambda_function" "send_email_lambda" {
  filename         = "lambda_function_compressed.zip"  
  function_name    = "sendEmailFunction"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler" 
  runtime          = "python3.8" 
 
  environment {
    variables = {
      SENDER_EMAIL    = var.sender_email
      RECIPIENT_EMAIL = var.recipient_email
      environment = var.common_resource_name
    }
  }
}

resource "aws_s3_bucket_notification" "notify_state_file_changed" {
  bucket = "terraform-s3-day2"

  lambda_function {
    lambda_function_arn = aws_lambda_function.send_email_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "allow_triggering_s3" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.send_email_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::terraform-s3-day2"
}