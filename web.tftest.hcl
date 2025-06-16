run "setup_tests" {
  module {
    source = "./."
  }

  assert {
    condition = module.output.instance_type == "t2.micro"
    error_message = "Expected instance type to be t2.micro"
  }
}
