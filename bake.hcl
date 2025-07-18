target "pytest" {
  output = ["type=docker"]
  tags = ["pytest:latest"]
}