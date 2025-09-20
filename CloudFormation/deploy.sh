aws cloudformation create-stack \
  --stack-name ec2-vpc-stack \
  --template-body file://ec2-vpc.yml \
  --parameters ParameterKey=KeyName,ParameterValue=your-keypair-name \
  --capabilities CAPABILITY_NAMED_IAM
