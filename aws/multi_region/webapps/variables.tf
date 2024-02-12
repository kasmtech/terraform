variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
  type        = string
}

variable "aws_domain_name" {
  description = "The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https"
  type        = string
}

variable "webapp_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm WebApp instances"
  type        = number
}

variable "agent_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm Agent instances"
  type        = number
  default     = 0
}

variable "cpx_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm CPX instances"
  type        = number
  default     = 0
}

variable "database_password" {
  description = "The password for the database. No special characters"
  type        = string
  sensitive   = true
}

variable "redis_password" {
  description = "The password for the database. No special characters"
  type        = string
  sensitive   = true
}

variable "service_registration_token" {
  description = "The service registration token value for cpx RDP servers to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true
  default     = ""
}

variable "manager_token" {
  description = "The Manager Token used by Kasm Agents to authenticate. No special characters"
  type        = string
  sensitive   = true
}

variable "swap_size" {
  description = "The amount of swap (in MB) to configure inside the compute instances"
  type        = number
}

variable "num_webapps" {
  description = "The number of WebApp role servers to create in the deployment"
  type        = number
}

variable "webapp_instance_type" {
  description = "The instance type for the webapps"
  type        = string
}

variable "webapp_security_group_id" {
  description = "WebApp security group ID"
  type        = string
}

variable "load_balancer_subnet_ids" {
  description = "ALB subnet IDs created to host webapps in the primary region"
  type        = list(string)
}

variable "webapp_subnet_ids" {
  description = "WebApp subnet IDs created to host webapps in the primary region"
  type        = list(string)
}

variable "cpx_instance_type" {
  description = "the instance type for the CPX nodes"
  type        = string
  default     = ""
}

variable "cpx_subnet_id" {
  description = "Subnet ID created for Kasm CPX nodes"
  type        = string
  default     = ""
}

variable "num_agents" {
  description = "The number of Agent Role Servers to create in the deployment"
  type        = number
  default     = 0
}

variable "agent_instance_type" {
  description = "the instance type for the agents"
  type        = string
  default     = ""
}

variable "agent_subnet_id" {
  description = "Subnet ID created for agents"
  type        = string
  default     = ""
}

variable "agent_security_group_id" {
  description = "Kasm Agent security group ID"
  type        = string
  default     = ""
}

variable "primary_aws_region" {
  description = "The AWS region for primary region of the deployment. (e.g us-east-1)"
  type        = string
}

variable "faux_aws_region" {
  description = "The AWS region this WebApp is supposed to represent even though it will be created in the primary region of the deployment. (e.g us-east-1)"
  type        = string
}

variable "num_cpx_nodes" {
  description = "The number of cpx  Role Servers to create in the deployment"
  type        = number
  default     = 0
}

variable "kasm_build" {
  description = "The URL for the Kasm Workspaces build"
  type        = string
}

variable "kasm_db_ip" {
  description = "The IP/DNS name of the Kasm database"
  type        = string
}

variable "zone_name" {
  description = "A name given to the Kasm deployment Zone"
  type        = string
}

variable "aws_key_pair" {
  description = "The name of an aws keypair to use."
  type        = string
}

variable "ec2_ami" {
  description = "The AMI used for the EC2 nodes. Recommended Ubuntu 20.04 LTS."
  type        = string
}

variable "certificate_arn" {
  description = "The certificate ARN created in the primary region for use with all load balancers in the deployment."
  type        = string
}

variable "load_balancer_log_bucket" {
  description = "S3 bucket name for load balancers to forward access logs to"
  type        = string
}

variable "primary_vpc_id" {
  description = "The VPC ID of the primary region"
  type        = string
}

variable "aws_ssm_iam_role_name" {
  description = "The name of the SSM EC2 role to associate with Kasm VMs for SSH access"
  type        = string
  default     = ""
}

variable "load_balancer_security_group_id" {
  description = "Security Group ID for the Primary region's load balancer"
  type        = string
}

variable "cpx_security_group_id" {
  description = "CPX security group ID"
  type        = string
  default     = ""
}

variable "aws_to_kasm_zone_map" {
  description = "AWS regions mapped to Kasm Deployment Zone names"
  type        = map(any)
  default = {
    us-east-1      = "USA-(Virginia)"
    us-east-2      = "USA-(Ohio)"
    us-west-1      = "USA-(California)"
    us-west-2      = "USA-(Oregon)"
    ap-south-1     = "India-(Mumbai)"
    ap-northeast-3 = "Japan-(Osaka)"
    ap-northeast-2 = "S-Korea-(Seoul)"
    ap-southeast-1 = "Singapore"
    ap-southeast-2 = "Austrailia-(Sydney)"
    ap-northeast-1 = "Japan-(Tokyo)"
    ca-central-1   = "Canada-(Montreal)"
    eu-central-1   = "Germany-(Frankfurt)"
    eu-west-1      = "Ireland-(Dublin)"
    eu-west-2      = "UK-(London)"
    eu-west-3      = "France-(Paris)"
    eu-north-1     = "Sweden-(Stockholm)"
    eu-south-1     = "Italy-(Milan)"
    eu-south-2     = "Spain-(Aragon)"
    eu-central-1   = "Switzerland-(Zurich)"
    sa-east-1      = "Brazil-(Sao-Paulo)"
    af-south-1     = "Africa-(Cape-Town)"
    ap-east-1      = "China-(Hong-Kong)"
    ap-south-2     = "India-(Hyderbad)"
    ap-southeast-3 = "Indonesia-(Jakarta)"
    ap-southeast-4 = "Austrailia-(Melbourne)"
    me-south-1     = "Manama-(Bahrain)"
    me-central-1   = "United-Arab-Emirates"
  }
}
