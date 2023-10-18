terraform {
  required_providers {
    airbyte = {
      source = "airbytehq/airbyte"
      version = "0.3.3"
    }
  }
}

provider "airbyte" {
  // If running locally (Airbyte OSS) with docker-compose using the airbyte-proxy, 
  // include the actual password/username you've set up (or use the defaults below)
  password = "password"
  username = "airbyte"
  
  // if running locally (Airbyte OSS), include the server url to the airbyte-api-server
  server_url = "http://localhost:8006/v1/" // (and UI is at http://airbyte.company.com:8000)
}