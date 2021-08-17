cidr               = "10.1.0.0/16"
envname            = "dev"
region             = "ap-southeast-1"
pubsubnets         = ["10.1.0.0/24","10.1.1.0/24","10.1.2.0/24"]
prisubnets         = ["10.1.3.0/24","10.1.4.0/24","10.1.5.0/24"]
datasubnets        = ["10.1.6.0/24","10.1.7.0/24","10.1.8.0/24"]
envname_pubsubnet  = "dev_dev_pubsubnet"
# envname_prisubnet  = "dev_dev_prisubnet"
# envname_datasubnet = "dev_dev_datasubnet"
azs = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
ami = "ami-0f511ead81ccde020"
type = "t2.micro"