data "archive_file" "zip" {
  type        = "zip"
  source_file = "${path.module}/src/bin/lambda-go"
  output_path = "${path.module}/lambda_function.zip"
}
