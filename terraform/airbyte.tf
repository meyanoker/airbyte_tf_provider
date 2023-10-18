resource "airbyte_source_slack" "source_demo" {
  configuration = {
    channel_filter = [
      "support_technique",
      "dbt",
      "général",
      "events",
      "aléatoire"
    ]
    credentials = {
      source_slack_authentication_mechanism_api_token = {
        api_token    = var.source_api_token
        option_title = "API Token Credentials"
      }
    }
    join_channels   = true
    lookback_window = 0
    source_type     = "slack"
    start_date      = "2023-01-01T00:00:00Z"
  }
  name         = "[POC] Source de données - Slack"
  workspace_id = var.workspace_id
}


resource "airbyte_destination_s3" "destination_demo" {
  configuration = {
    access_key_id     = var.destination_access_key
    destination_type  = "s3"
    format = {
      destination_s3_output_format_csv_comma_separated_values = {
        flattening = "No flattening"
        format_type = "CSV"
      }
    }
    s3_bucket_name    = var.destination_bucket_name
    s3_bucket_path    = var.destination_bucket_path
    s3_bucket_region  = var.destination_region
    secret_access_key = var.destination_secret_key
  }
  name         = "[POC] Destination - Bucket S3"
  workspace_id = var.workspace_id
}

 

resource "airbyte_connection" "connection_demo" {
  destination_id       = airbyte_destination_s3.destination_demo.destination_id
  source_id            = airbyte_source_slack.source_demo.source_id
  name                 = "[POC] Slack vers Bucket S3"
	namespace_definition = "source"
  configurations       = {
    streams = [
      {
        name = "channel_messages"
				sync_mode = "full_refresh_overwrite"
      }
    ]
  }

	schedule = {
		schedule_type = "manual"
	}
}