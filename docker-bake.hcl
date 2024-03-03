variable "VERSION" {
  default = "2024.2.0"
}

group "default" {
  targets = ["default"]
}

target "default" {
  tags = ["quay.io/seiferma/bitwarden-cli:${VERSION}", "quay.io/seiferma/bitwarden-cli:latest"]
  args = {
    CLI_VERSION = "${VERSION}"
  }
}
