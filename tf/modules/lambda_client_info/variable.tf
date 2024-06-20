variable "client_info_lmabda_name" {
    type = string
    description = "the name of the client info lmabda"
    default = "myLambdaFunction"
}

variable "aws_iams_3_write_policy_name" {
    type = string
    description = "the name of the client info lmabda"
    default = "S3WritePolicy"
}

variable "sns_topic_subscription_email" {
    type = string
    description = "the email for the topic subscription"
    default = "snirwork1@gmail.com"
}

variable "aws_sns_topic_name" {
    type = string
    description = "the name of the sns topic"
    default = "MyLambdaNotificationTopic"
}