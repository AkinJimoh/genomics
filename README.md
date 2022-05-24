# Genomics Test
`Clone the repo from this`
[URL](https://github.com/AkinJimoh/genomics.git)

You will need to change the value of `profile = "atmj.io"` in the `terraform.tfvars` file.

# Deploying The Infrsatructure
Navigate to the root directory and run `terraform init` followed by a `terraform plan` and `terraform apply`

Once deployed, upload a test `jpg,jpeg,png` into the `gel-XXXX-src` s3 bucket and the implemented logic should strip out the metadata and upload the file to the `gel-XXXX-dest` bucket.