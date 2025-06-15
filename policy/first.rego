# policy/deny_public_s3.rego
package main

deny[msg] {
  input.resource_changes[_].change.after.bucket == "my-public-bucket"
  msg = "Public S3 bucket is not allowed."
}
