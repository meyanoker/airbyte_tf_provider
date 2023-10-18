variable "workspace_id" {
  type = string
  default = "<workspace_id à renseigner>"
}

variable "source_api_token" {
    type = string
    default = "<api-token-à-renseigner>"
}

variable "destination_access_key" {
    type = string
    default = "<access-key-à-renseigner>"
}
variable "destination_secret_key" {
    type = string
    default = "<secret-key-à-renseigner>"
}

# Nom du folder qui contiendra les données: si valeur = "csv", créer un dossier "csv" dans le Bucket S3
variable "destination_bucket_path" {
    type = string
    default = "csv"
}

variable "destination_bucket_name" {
    type = string
    default = "<nom-du-bucket-à-renseigner>"
}

variable "destination_region" {
  type = string
  default = "<région-du-bucket-à-renseigner>"
}

variable "tags" {
  default = {
    owner   = "Meyan OKER"
    project = "meyan-poc-airbyte"
  }
}