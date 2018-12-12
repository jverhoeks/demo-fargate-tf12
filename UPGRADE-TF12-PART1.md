# First take at Terraform 0.12

After the webinar of Hashicorp i felt inspired and started to test the latest alpha4 and upgrade some demo repo i wrote for a meetup
https://github.com/edrans/meetup-bcn-ecs-terraform

First in terraform 0.11

## Terraform 0.11

```bash
$terraform init
Initializing modules...
- module.ecs_cluster
  Getting source "fargate-cluster"
- module.ecs_task
  Getting source "fargate-task"

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (1.51.0)...
- Downloading plugin for provider "template" (1.0.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.template: version = "~> 1.0"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

```
bash-4.4$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.aws_caller_identity.current: Refreshing state...
data.aws_vpc.default: Refreshing state...
data.aws_iam_policy_document.ecs_service_task_role_assume: Refreshing state...
data.aws_caller_identity.current: Refreshing state...
data.aws_iam_policy_document.ecs_service_task_execution_role_assume: Refreshing state...
data.aws_region.current: Refreshing state...
data.aws_region.current: Refreshing state...
data.aws_iam_policy_document.ecs_task_allow_awslogs_policy: Refreshing state...
data.aws_subnet_ids.default: Refreshing state...
data.aws_subnet.default[2]: Refreshing state...
data.aws_subnet.default[1]: Refreshing state...
data.aws_subnet.default[0]: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  + aws_dynamodb_table.basic-dynamodb-table
      id:                                         <computed>
      arn:                                        <computed>
      attribute.#:                                "2"
      attribute.2184528078.name:                  "ClientIP"
      attribute.2184528078.type:                  "S"
      attribute.2207960920.name:                  "ServerIP"
      attribute.2207960920.type:                  "S"
      billing_mode:                               "PROVISIONED"
      hash_key:                                   "ClientIP"
      name:                                       "DemoTable"
      point_in_time_recovery.#:                   <computed>
      range_key:                                  "ServerIP"
      read_capacity:                              "1"
      server_side_encryption.#:                   <computed>
      stream_arn:                                 <computed>
      stream_label:                               <computed>
      stream_view_type:                           <computed>
      tags.%:                                     "2"
      tags.Environment:                           "demo"
      tags.Name:                                  "dynamodb-table-demo"
      write_capacity:                             "1"

  + aws_ecr_repository.registry
      id:                                         <computed>
      arn:                                        <computed>
      name:                                       "demo"
      registry_id:                                <computed>
      repository_url:                             <computed>

  + aws_iam_role_policy.ecs_task_allow_dynamodb_demo
      id:                                         <computed>
      name:                                       "ecs-allow-dynamodb-demo"
      policy:                                     "{\n    \"Version\": \"2012-10-17\",\n    \"Statement\": [\n        {\n            \"Sid\": \"ListAndDescribe\",\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"dynamodb:List*\",\n                \"dynamodb:DescribeReservedCapacity*\",\n                \"dynamodb:DescribeLimits\",\n                \"dynamodb:DescribeTimeToLive\"\n            ],\n            \"Resource\": \"*\"\n        },\n        {\n            \"Sid\": \"SpecificTable\",\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"dynamodb:BatchGet*\",\n                \"dynamodb:DescribeStream\",\n                \"dynamodb:DescribeTable\",\n                \"dynamodb:Get*\",\n                \"dynamodb:Query\",\n                \"dynamodb:Scan\",\n                \"dynamodb:BatchWrite*\",\n                \"dynamodb:CreateTable\",\n                \"dynamodb:Delete*\",\n                \"dynamodb:Update*\",\n                \"dynamodb:PutItem\"\n            ],\n            \"Resource\": \"${aws_dynamodb_table.basic-dynamodb-table.arn}\"\n        }\n    ]\n}\n"
      role:                                       "${module.ecs_task.task_iam_role_id}"

  + aws_iam_service_linked_role.ecs
      id:                                         <computed>
      arn:                                        <computed>
      aws_service_name:                           "ecs.amazonaws.com"
      create_date:                                <computed>
      name:                                       <computed>
      path:                                       <computed>
      unique_id:                                  <computed>

  + aws_security_group.ecs_demo
      id:                                         <computed>
      arn:                                        <computed>
      description:                                "Managed by Terraform"
      egress.#:                                   "1"
      egress.482069346.cidr_blocks.#:             "1"
      egress.482069346.cidr_blocks.0:             "0.0.0.0/0"
      egress.482069346.description:               ""
      egress.482069346.from_port:                 "0"
      egress.482069346.ipv6_cidr_blocks.#:        "0"
      egress.482069346.prefix_list_ids.#:         "0"
      egress.482069346.protocol:                  "-1"
      egress.482069346.security_groups.#:         "0"
      egress.482069346.self:                      "false"
      egress.482069346.to_port:                   "0"
      ingress.#:                                  "1"
      ingress.516175195.cidr_blocks.#:            "1"
      ingress.516175195.cidr_blocks.0:            "0.0.0.0/0"
      ingress.516175195.description:              ""
      ingress.516175195.from_port:                "8080"
      ingress.516175195.ipv6_cidr_blocks.#:       "0"
      ingress.516175195.prefix_list_ids.#:        "0"
      ingress.516175195.protocol:                 "tcp"
      ingress.516175195.security_groups.#:        "0"
      ingress.516175195.self:                     "false"
      ingress.516175195.to_port:                  "8080"
      name:                                       "SGECS-demo-demo"
      owner_id:                                   <computed>
      revoke_rules_on_delete:                     "false"
      vpc_id:                                     "vpc-eeb44287"

  + module.ecs_cluster.aws_cloudwatch_log_group.log_group
      id:                                         <computed>
      arn:                                        <computed>
      name:                                       <computed>
      name_prefix:                                "/ecs/cluster/demo-"
      retention_in_days:                          "7"
      tags.%:                                     "2"
      tags.Name:                                  "/ecs/cluster/demo"
      tags.role:                                  "cloudwatch"

  + module.ecs_cluster.aws_ecs_cluster.ecs
      id:                                         <computed>
      arn:                                        <computed>
      name:                                       "demo"

  + module.ecs_cluster.aws_iam_role.ecs_service_task_execution_role
      id:                                         <computed>
      arn:                                        <computed>
      assume_role_policy:                         "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"\",\n      \"Effect\": \"Allow\",\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ecs-tasks.amazonaws.com\"\n      }\n    }\n  ]\n}"
      create_date:                                <computed>
      force_detach_policies:                      "false"
      max_session_duration:                       "3600"
      name:                                       <computed>
      name_prefix:                                "EcsExecution-demo-"
      path:                                       "/"
      unique_id:                                  <computed>

  + module.ecs_cluster.aws_iam_role_policy.ecs_task_allow_awslogs
      id:                                         <computed>
      name:                                       "ecs-allow-awslogs"
      policy:                                     "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"\",\n      \"Effect\": \"Allow\",\n      \"Action\": [\n        \"logs:PutLogEvents\",\n        \"logs:DescribeLogStreams\",\n        \"logs:CreateLogStream\",\n        \"logs:CreateLogGroup\"\n      ],\n      \"Resource\": \"arn:aws:logs:*:*:*\"\n    }\n  ]\n}"
      role:                                       "${aws_iam_role.ecs_service_task_execution_role.id}"

  + module.ecs_cluster.aws_iam_role_policy_attachment.ecs_task_basic
      id:                                         <computed>
      policy_arn:                                 "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
      role:                                       "${aws_iam_role.ecs_service_task_execution_role.id}"

 <= module.ecs_task.data.aws_ecs_task_definition.task
      id:                                         <computed>
      family:                                     <computed>
      network_mode:                               <computed>
      revision:                                   <computed>
      status:                                     <computed>
      task_definition:                            "demo"
      task_role_arn:                              <computed>

 <= module.ecs_task.data.template_file.task_definition
      id:                                         <computed>
      rendered:                                   <computed>
      template:                                   "[\n{\n  \"cpu\": ${cpu},\n  \"memoryReservation\": ${mem},\n  \"essential\": true,\n  \"name\": \"${service_name}\",\n  \"image\": \"${image}\",\n  \"portMappings\": [\n    {\n      \"hostPort\": ${hostport},\n      \"containerPort\": ${containerport},\n      \"protocol\": \"tcp\"\n    }\n  ],\n  \"logConfiguration\": {\n          \"logDriver\": \"awslogs\",\n          \"options\": {\n              \"awslogs-group\": \"${log_group}\",\n              \"awslogs-region\": \"${region}\",\n              \"awslogs-stream-prefix\": \"${service_name}\"\n          }\n  }\n}\n]\n"
      vars.%:                                     <computed>

  + module.ecs_task.aws_ecs_service.service
      id:                                         <computed>
      cluster:                                    "demo"
      deployment_maximum_percent:                 "200"
      deployment_minimum_healthy_percent:         "100"
      desired_count:                              "0"
      enable_ecs_managed_tags:                    "false"
      iam_role:                                   <computed>
      launch_type:                                "FARGATE"
      name:                                       "demo"
      network_configuration.#:                    "1"
      network_configuration.0.assign_public_ip:   "true"
      network_configuration.0.security_groups.#:  <computed>
      network_configuration.0.subnets.#:          "3"
      network_configuration.0.subnets.1374269291: "subnet-8e6997e7"
      network_configuration.0.subnets.138190179:  "subnet-857167fd"
      network_configuration.0.subnets.1918786212: "subnet-eb192ea1"
      scheduling_strategy:                        "REPLICA"
      task_definition:                            "${var.family}:${max(aws_ecs_task_definition.task.revision, data.aws_ecs_task_definition.task.revision)}"

  + module.ecs_task.aws_ecs_task_definition.task
      id:                                         <computed>
      arn:                                        <computed>
      container_definitions:                      "${data.template_file.task_definition.rendered}"
      cpu:                                        "256"
      execution_role_arn:                         "${var.task_execution_role}"
      family:                                     "demo"
      memory:                                     "512"
      network_mode:                               "awsvpc"
      requires_compatibilities.#:                 "1"
      requires_compatibilities.3072437307:        "FARGATE"
      revision:                                   <computed>
      task_role_arn:                              "${aws_iam_role.ecs_service_task_role.arn}"

  + module.ecs_task.aws_iam_role.ecs_service_task_role
      id:                                         <computed>
      arn:                                        <computed>
      assume_role_policy:                         "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"\",\n      \"Effect\": \"Allow\",\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ecs-tasks.amazonaws.com\"\n      }\n    }\n  ]\n}"
      create_date:                                <computed>
      force_detach_policies:                      "false"
      max_session_duration:                       "3600"
      name:                                       <computed>
      name_prefix:                                "EcsTask-demo-"
      path:                                       "/"
      unique_id:                                  <computed>


Plan: 13 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

## Let's start migration to 0.12

First clean all the old state as this is test repo. _If you have live environment don't do this!_
Download the latest alpha from https://releases.hashicorp.com/terraform/

I like to use tfenv, but i requires some changes for the alpha

`brew install tfenv`
Apply:  https://github.com/tfutils/tfenv/pull/94/files

Edit /usr/local/Cellar/tfenv/0.6.0/libexec/tfenv-install` line 73:
```
if [[ $version == *alpha* ]]; then
  tarball_name="terraform_${version}_terraform_${version}_${os}.zip"
else
  tarball_name="terraform_${version}_${os}.zip"
```

Hashicorp did something strange with the filename, it included twice name and version

Run: `tfenv install 0.12.0-alpha4`


```bash
bash-4.4$ rm -rf .terraform/
bash-4.4$ tfenv list
  0.12.0-alpha1
  0.12.0-alpha2
  0.12.0-alpha4
* 0.11.10 (set by /usr/local/Cellar/tfenv/0.6.0/version)
  0.11.8
bash-4.4$ tfenv use 0.12.0-alpha4
[INFO] Switching to v0.12.0-alpha4
[INFO] Switching completed
```

### First try init

```
$terraform init

Error: Failed to download module

  on ecs_task.tf line 3, in module "ecs_cluster":
   3:   source = "fargate-cluster"

Error attempting to download module source code from "fargate-cluster": error
downloading 'file:///.terraform/modules/ecs_cluster/fargate-cluster': source
path error: stat /.terraform/modules/ecs_cluster/fargate-cluster: no such file
or directory
```

It can't find the directory. Terraform 0.12 has more strict parsing and requires current paths to include ./
Lets fix this:
```diff
diff --git a/ecs_task.tf b/ecs_task.tf
index 38b58e3..7000d7a 100644
--- a/ecs_task.tf
+++ b/ecs_task.tf
@@ -1,12 +1,12 @@
 // Use cluster module to create the Cluster
 module ecs_cluster {
-  source = "fargate-cluster"
+  source = "./fargate-cluster"
   name   = "${var.ecs_cluster_name}"
 }

 // use task module to create the fargate task
 module "ecs_task" {
-  source              = "fargate-task"
+  source              = "./fargate-task"
   task_execution_role = "${module.ecs_cluster.execution_role_arn}"
   service             = "${var.ecs_task["service"]}"
   family              = "${var.ecs_task["family"]}"
```

###  Second try
```bash
 bash-4.4$ terraform init
 Initializing modules...
 - ecs_cluster in fargate-cluster
 - ecs_task in fargate-task

 Initializing provider plugins...
 - Checking for available provider plugins...
 - Downloading plugin for provider "aws" (1.51.0)...
 - Downloading plugin for provider "aws (terraform-providers/aws)" (1.51.0)...

 The following providers do not have any version constraints in configuration,
 so the latest version was installed.

 To prevent automatic upgrades to new major versions that may contain breaking
 changes, it is recommended to add version = "..." constraints to the
 corresponding provider blocks in configuration, with the constraint strings
 suggested below.

 * provider.template: version = "~> 1.0"

 Terraform has been successfully initialized!

 You may now begin working with Terraform. Try running "terraform plan" to see
 any changes that are required for your infrastructure. All Terraform commands
 should now work.

 If you ever set or change modules or backend configuration for Terraform,
 rerun this command to reinitialize your working directory. If you forget, other
 commands will detect it and remind you to do so if necessary.
```

We have successfully initialized terraform

### Let's run a plan

```bash
bash-4.4$ terraform plan

Error: Failed to instantiate provider "aws" to obtain schema: Incompatible API version with plugin. Plugin version: 4, Client versions: [5]
```

The init copied the wrong aws provider, it's build against 0.11 and not compatible.
Lucky the installation includes a terraform provider: `terraform-provider-aws_v1.40.0-6-gb23683732-dev_x4`

Update terraform.tf with the new versions


```diff
diff --git a/terraform.tf b/terraform.tf
index eb219f8..c7fc0e8 100644
--- a/terraform.tf
+++ b/terraform.tf
@@ -22,13 +22,13 @@ data "aws_subnet" "default" {

 provider "aws" {
   #  region  = "${data.aws_region.current.name}"
-  version = "~> 1.36"
+  version = "= 1.40.0"
 }

 # If the running Terraform version doesn't meet these constraints,
 # an error is shown
 terraform {
-  required_version = ">= 0.11.4"
+  required_version = ">= 0.12"

   #  backend          "s3"             {}
 }
@@ -37,4 +37,3 @@ terraform {
 # resource "aws_iam_service_linked_role" "ecs" {
 #   aws_service_name = "ecs.amazonaws.com"
 # }
````

A terraform init still doesn't copy the right files and keep trying to download.
Workaround: Copy the provider into the .terraform directory.
I'm sure this is caused by tfenv and multiple terraform versions but for now it works.


```bash
$terraform init
rm .terraform/plugins/darwin_amd64/terraform-provider*
cp /usr/local/Cellar/tfenv/0.6.0/versions/0.12.0-alpha4/terraform-provider-aws_v1.40.0-6-gb23683732-dev_x4 .terraform/plugins/darwin_amd64/terraform-provider-aws_v1.40.0_x4
terraform init

terraform plan

bash-4.4$ terraform plan

Error: Unsupported block type

  on fargate-task/ecs_task.tf line 49, in data "template_file" "task_definition":
  49:   vars {

Blocks of type "vars" are not expected here. Did you mean to define argument
"vars"? If so, use the equals sign to assign it a value.


Error: Unsupported block type

  on /Users/jacob/git/jacob/demo-fargate-tf12/dynamodb.tf line 19, in resource "aws_dynamodb_table" "basic-dynamodb-table":
  19:   tags {

Blocks of type "tags" are not expected here. Did you mean to define argument
"tags"? If so, use the equals sign to assign it a value.
```

### We have working provider. Now see what are these errors

Lucky for us 0.12 comes with much better error messages and explains the issue. We have to use =

```diff
diff --git a/dynamodb.tf b/dynamodb.tf
index 43fed5a..7855b54 100644
--- a/dynamodb.tf
+++ b/dynamodb.tf
@@ -16,7 +16,7 @@ resource "aws_dynamodb_table" "basic-dynamodb-table" {
     type = "S"
   }

-  tags {
+  tags = {
     Name        = "dynamodb-table-demo"
     Environment = "demo"
   }
diff --git a/fargate-task/ecs_task.tf b/fargate-task/ecs_task.tf
index 0a95fee..8dbb27f 100644
--- a/fargate-task/ecs_task.tf
+++ b/fargate-task/ecs_task.tf
@@ -46,7 +46,7 @@ resource "aws_ecs_service" "service" {
 data "template_file" "task_definition" {
   template = "${file("${path.module}/task_definition.json")}"

-  vars {
+  vars = {
     cpu           = "${var.cpu}"
     mem           = "${var.memory}"
     image         = "${var.image}"
```

### Next take

```bash
bash-4.4$ terraform plan

Error: Incorrect attribute value type

 on fargate-task/ecs_task.tf line 30, in resource "aws_ecs_service" "service":
 30:     subnets          = ["${var.subnet_ids}"]

Inappropriate value for attribute "subnets": set of string required.


Error: Incorrect attribute value type

 on fargate-task/ecs_task.tf line 31, in resource "aws_ecs_service" "service":
 31:     security_groups  = ["${var.security_group_ids}"]

Inappropriate value for attribute "security_groups": set of string required.
```

In 0.11 you needed to encapsulate lists always in [] even if it was a string. Now it's aware.
Remove the square brackets.

```diff
diff --git a/fargate-task/ecs_task.tf b/fargate-task/ecs_task.tf
index 8dbb27f..8241c71 100644
--- a/fargate-task/ecs_task.tf
+++ b/fargate-task/ecs_task.tf
@@ -27,8 +27,8 @@ resource "aws_ecs_service" "service" {

   // Networkconfiguration onlu required for awsvpc networking
   network_configuration {
-    subnets          = ["${var.subnet_ids}"]
-    security_groups  = ["${var.security_group_ids}"]
+    subnets          = "${var.subnet_ids}"
+    security_groups  = "${var.security_group_ids}"
     assign_public_ip = "${var.assign_public_ip}"
   }
```

### Another try

```bash
bash-4.4$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

module.ecs_task.data.aws_region.current: Refreshing state...
module.ecs_cluster.data.aws_iam_policy_document.ecs_service_task_execution_role_assume: Refreshing state...
data.aws_region.current: Refreshing state...
data.aws_caller_identity.current: Refreshing state...
module.ecs_task.data.aws_caller_identity.current: Refreshing state...
module.ecs_cluster.data.aws_iam_policy_document.ecs_task_allow_awslogs_policy: Refreshing state...
data.aws_vpc.default: Refreshing state...
module.ecs_task.data.aws_iam_policy_document.ecs_service_task_role_assume: Refreshing state...
data.aws_subnet_ids.default: Refreshing state...

Error: Invalid index

  on /Users/jacob/git/jacob/demo-fargate-tf12/terraform.tf line 20, in data "aws_subnet" "default":
  20:   id    = "${data.aws_subnet_ids.default.ids[count.index]}"
    |----------------
    | count.index is 0
    | data.aws_subnet_ids.default.ids is set of string with 3 elements

This value does not have any indices.


Error: Invalid index

  on /Users/jacob/git/jacob/demo-fargate-tf12/terraform.tf line 20, in data "aws_subnet" "default":
  20:   id    = "${data.aws_subnet_ids.default.ids[count.index]}"
    |----------------
    | count.index is 1
    | data.aws_subnet_ids.default.ids is set of string with 3 elements

This value does not have any indices.
```

This is on my, it's unused code that doesn't work anymore. It can be removed.


```diff
diff --git a/terraform.tf b/terraform.tf
index c7fc0e8..6cd2d38 100644
--- a/terraform.tf
+++ b/terraform.tf
@@ -14,11 +14,11 @@ data "aws_subnet_ids" "default" {
   vpc_id = "${data.aws_vpc.default.id}"
 }

-// retreive subnets for default VPC
-data "aws_subnet" "default" {
-  count = "${length(data.aws_subnet_ids.default.ids)}"
-  id    = "${data.aws_subnet_ids.default.ids[count.index]}"
-}
+# // retreive subnets for default VPC
+# data "aws_subnet" "default" {
+#   count = "${length(data.aws_subnet_ids.default.ids)}"
+#   id    = "${data.aws_subnet_ids.default.ids[count.index]}"
+# }

 provider "aws" {
   #  region  = "${data.aws_region.current.name}"
```

### Final Plan?

We fixed many issues and can finally see the new plan output


```
bash-4.4$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

module.ecs_task.data.aws_region.current: Refreshing state...
data.aws_region.current: Refreshing state...
module.ecs_task.data.aws_caller_identity.current: Refreshing state...
data.aws_caller_identity.current: Refreshing state...
module.ecs_cluster.data.aws_iam_policy_document.ecs_task_allow_awslogs_policy: Refreshing state...
data.aws_vpc.default: Refreshing state...
module.ecs_cluster.data.aws_iam_policy_document.ecs_service_task_execution_role_assume: Refreshing state...
module.ecs_task.data.aws_iam_policy_document.ecs_service_task_role_assume: Refreshing state...
data.aws_subnet_ids.default: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # aws_dynamodb_table.basic-dynamodb-table will be created
  + resource "aws_dynamodb_table" "basic-dynamodb-table" {
      + arn              = (known after apply)
      + hash_key         = "ClientIP"
      + id               = (known after apply)
      + name             = "DemoTable"
      + range_key        = "ServerIP"
      + read_capacity    = 1
      + stream_arn       = (known after apply)
      + stream_label     = (known after apply)
      + stream_view_type = (known after apply)
      + tags             = {
          + "Environment" = "demo"
          + "Name"        = "dynamodb-table-demo"
        }
      + write_capacity   = 1

      + attribute {
          + name = "ServerIP"
          + type = "S"
        }
      + attribute {
          + name = "ClientIP"
          + type = "S"
        }

      + timeouts {
        }
    }

  # aws_ecr_repository.registry will be created
  + resource "aws_ecr_repository" "registry" {
      + arn            = (known after apply)
      + id             = (known after apply)
      + name           = "demo"
      + registry_id    = (known after apply)
      + repository_url = (known after apply)

      + timeouts {
        }
    }

  # aws_iam_role_policy.ecs_task_allow_dynamodb_demo will be created
  + resource "aws_iam_role_policy" "ecs_task_allow_dynamodb_demo" {
      + id     = (known after apply)
      + name   = "ecs-allow-dynamodb-demo"
      + policy = (known after apply)
      + role   = (known after apply)
    }

  # aws_iam_service_linked_role.ecs will be created
  + resource "aws_iam_service_linked_role" "ecs" {
      + arn              = (known after apply)
      + aws_service_name = "ecs.amazonaws.com"
      + create_date      = (known after apply)
      + id               = (known after apply)
      + name             = (known after apply)
      + path             = (known after apply)
      + unique_id        = (known after apply)
    }

  # aws_security_group.ecs_demo will be created
  + resource "aws_security_group" "ecs_demo" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + id                     = (known after apply)
      + name                   = "SGECS-demo-demo"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + vpc_id                 = "vpc-eeb44287"

      + egress {
          + cidr_blocks = [
              + "0.0.0.0/0",
            ]
          + from_port   = 0
          + protocol    = "-1"
          + self        = false
          + to_port     = 0
        }

      + ingress {
          + cidr_blocks = [
              + "0.0.0.0/0",
            ]
          + from_port   = 8080
          + protocol    = "tcp"
          + self        = false
          + to_port     = 8080
        }

      + timeouts {
        }
    }

  # module.ecs_cluster.aws_cloudwatch_log_group.log_group will be created
  + resource "aws_cloudwatch_log_group" "log_group" {
      + arn               = (known after apply)
      + id                = (known after apply)
      + name              = (known after apply)
      + name_prefix       = "/ecs/cluster/demo-"
      + retention_in_days = 7
      + tags              = {
          + "Name" = "/ecs/cluster/demo"
          + "role" = "cloudwatch"
        }
    }

  # module.ecs_cluster.aws_ecs_cluster.ecs will be created
  + resource "aws_ecs_cluster" "ecs" {
      + arn  = (known after apply)
      + id   = (known after apply)
      + name = "demo"
    }

  # module.ecs_cluster.aws_iam_role.ecs_service_task_execution_role will be created
  + resource "aws_iam_role" "ecs_service_task_execution_role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "ecs-tasks.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + max_session_duration  = 3600
      + name                  = (known after apply)
      + name_prefix           = "EcsExecution-demo-"
      + path                  = "/"
      + unique_id             = (known after apply)
    }

  # module.ecs_cluster.aws_iam_role_policy.ecs_task_allow_awslogs will be created
  + resource "aws_iam_role_policy" "ecs_task_allow_awslogs" {
      + id     = (known after apply)
      + name   = "ecs-allow-awslogs"
      + policy = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "logs:PutLogEvents",
                          + "logs:DescribeLogStreams",
                          + "logs:CreateLogStream",
                          + "logs:CreateLogGroup",
                        ]
                      + Effect   = "Allow"
                      + Resource = "arn:aws:logs:*:*:*"
                      + Sid      = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + role   = (known after apply)
    }

  # module.ecs_cluster.aws_iam_role_policy_attachment.ecs_task_basic will be created
  + resource "aws_iam_role_policy_attachment" "ecs_task_basic" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
      + role       = (known after apply)
    }

  # module.ecs_task.data.aws_ecs_task_definition.task will be read during apply
  # (config refers to values not yet known)
 <= data "aws_ecs_task_definition" "task"  {
      + family          = (known after apply)
      + id              = (known after apply)
      + network_mode    = (known after apply)
      + revision        = (known after apply)
      + status          = (known after apply)
      + task_definition = "demo"
      + task_role_arn   = (known after apply)
    }

  # module.ecs_task.data.template_file.task_definition will be read during apply
  # (config refers to values not yet known)
 <= data "template_file" "task_definition"  {
      + id       = (known after apply)
      + rendered = (known after apply)
      + template = "[\n{\n  \"cpu\": ${cpu},\n  \"memoryReservation\": ${mem},\n  \"essential\": true,\n  \"name\": \"${service_name}\",\n  \"image\": \"${image}\",\n  \"portMappings\": [\n    {\n      \"hostPort\": ${hostport},\n      \"containerPort\": ${containerport},\n      \"protocol\": \"tcp\"\n    }\n  ],\n  \"logConfiguration\": {\n          \"logDriver\": \"awslogs\",\n          \"options\": {\n              \"awslogs-group\": \"${log_group}\",\n              \"awslogs-region\": \"${region}\",\n              \"awslogs-stream-prefix\": \"${service_name}\"\n          }\n  }\n}\n]\n"
      + vars     = {
          + "cluster_name"  = "demo"
          + "containerport" = "8080"
          + "cpu"           = "256"
          + "hostport"      = "8080"
          + "image"         = (known after apply)
          + "log_group"     = (known after apply)
          + "mem"           = "512"
          + "region"        = "us-east-2"
          + "service_name"  = "demo"
        }
    }

  # module.ecs_task.aws_ecs_service.service will be created
  + resource "aws_ecs_service" "service" {
      + cluster                            = "demo"
      + deployment_maximum_percent         = 200
      + deployment_minimum_healthy_percent = 100
      + desired_count                      = 0
      + iam_role                           = (known after apply)
      + id                                 = (known after apply)
      + launch_type                        = "FARGATE"
      + name                               = "demo"
      + scheduling_strategy                = "REPLICA"
      + task_definition                    = (known after apply)

      + network_configuration {
          + assign_public_ip = true
          + security_groups  = (known after apply)
          + subnets          = [
              + "subnet-8e6997e7",
              + "subnet-eb192ea1",
              + "subnet-857167fd",
            ]
        }
    }

  # module.ecs_task.aws_ecs_task_definition.task will be created
  + resource "aws_ecs_task_definition" "task" {
      + arn                      = (known after apply)
      + container_definitions    = (known after apply)
      + cpu                      = "256"
      + execution_role_arn       = (known after apply)
      + family                   = "demo"
      + id                       = (known after apply)
      + memory                   = "512"
      + network_mode             = "awsvpc"
      + requires_compatibilities = [
          + "FARGATE",
        ]
      + revision                 = (known after apply)
      + task_role_arn            = (known after apply)
    }

  # module.ecs_task.aws_iam_role.ecs_service_task_role will be created
  + resource "aws_iam_role" "ecs_service_task_role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "ecs-tasks.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + max_session_duration  = 3600
      + name                  = (known after apply)
      + name_prefix           = "EcsTask-demo-"
      + path                  = "/"
      + unique_id             = (known after apply)
    }

Plan: 13 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

##  0.12 auto upgrade

Terraform has a command to automatically upgrade your 0.11 code to 0.12. This removed the "${ }" where possible.
Let's try this on this code

### Upgrade fargate-cluster module


```bash
bash-4.4$ cd fargate-cluster
bash-4.4$ terraform 0.12upgrade

This command will rewrite the configuration files in the given directory so
that they use the new syntax features from Terraform v0.12, and will identify
any constructs that may need to be adjusted for correct operation with
Terraform v0.12.

We recommend using this command in a clean version control work tree, so that
you can easily see the proposed changes as a diff against the latest commit.
If you have uncommited changes already present, we recommend aborting this
command and dealing with them before running this command again.

Would you like to upgrade the module in the current directory?
  Only 'yes' will be accepted to confirm.

  Enter a value: yes

-----------------------------------------------------------------------------

Upgrade complete!

The configuration files were upgraded successfully. Use your version control
system to review the proposed changes, make any necessary adjustments, and
then commit.
```

That went quick, it's a small module. This is the output:
As you see not all are remove `"/ecs/cluster/${var.name}-"` is kept because it's included in a bigger string
`"${var.gdpr_delete_days}"` is changed to: `var.gdpr_delete_days`

```diff
diff --git a/fargate-cluster/cloudwatch.tf b/fargate-cluster/cloudwatch.tf
index 0a216db..eadde27 100644
--- a/fargate-cluster/cloudwatch.tf
+++ b/fargate-cluster/cloudwatch.tf
@@ -1,10 +1,14 @@
 // Create Cloudwatch Log Group with retention
 resource "aws_cloudwatch_log_group" "log_group" {
   name_prefix       = "/ecs/cluster/${var.name}-"
-  retention_in_days = "${var.gdpr_delete_days}"
+  retention_in_days = var.gdpr_delete_days

-  tags = "${merge(var.tags,map(
-    "role"               , "cloudwatch",
-    "Name"               , "/ecs/cluster/${var.name}",
-  ))}"
+  tags = merge(
+    var.tags,
+    {
+      "role" = "cloudwatch"
+      "Name" = "/ecs/cluster/${var.name}"
+    },
+  )
 }
+
diff --git a/fargate-cluster/ecs_cluster.tf b/fargate-cluster/ecs_cluster.tf
index cf3101e..e28efa5 100644
--- a/fargate-cluster/ecs_cluster.tf
+++ b/fargate-cluster/ecs_cluster.tf
@@ -1,13 +1,13 @@
 // ECS Cluster
 resource "aws_ecs_cluster" "ecs" {
-  name = "${var.name}"
+  name = var.name
 }

 // FARGATE Execution Role
 resource "aws_iam_role" "ecs_service_task_execution_role" {
   name_prefix = "EcsExecution-${var.name}-"

-  assume_role_policy = "${data.aws_iam_policy_document.ecs_service_task_execution_role_assume.json}"
+  assume_role_policy = data.aws_iam_policy_document.ecs_service_task_execution_role_assume.json
 }

 data "aws_iam_policy_document" "ecs_service_task_execution_role_assume" {
@@ -23,16 +23,16 @@ data "aws_iam_policy_document" "ecs_service_task_execution_role_assume" {

 // Attach  Default Execution Policy
 resource "aws_iam_role_policy_attachment" "ecs_task_basic" {
-  role       = "${aws_iam_role.ecs_service_task_execution_role.id}"
+  role       = aws_iam_role.ecs_service_task_execution_role.id
   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
 }

 // Additional Policy to allow the task to manage cloudwatch log groups
 resource "aws_iam_role_policy" "ecs_task_allow_awslogs" {
   name = "ecs-allow-awslogs"
-  role = "${aws_iam_role.ecs_service_task_execution_role.id}"
+  role = aws_iam_role.ecs_service_task_execution_role.id

-  policy = "${data.aws_iam_policy_document.ecs_task_allow_awslogs_policy.json}"
+  policy = data.aws_iam_policy_document.ecs_task_allow_awslogs_policy.json
 }

 data "aws_iam_policy_document" "ecs_task_allow_awslogs_policy" {
@@ -49,3 +49,4 @@ data "aws_iam_policy_document" "ecs_task_allow_awslogs_policy" {
     ]
   }
 }
+
diff --git a/fargate-cluster/output.tf b/fargate-cluster/output.tf
index 11c37aa..e2d6713 100644
--- a/fargate-cluster/output.tf
+++ b/fargate-cluster/output.tf
@@ -1,28 +1,29 @@
 // The Amazon Resource Name (ARN) specifying the role
 output "execution_role_id" {
   description = "IAM Role ID for execution Role"
-  value       = "${aws_iam_role.ecs_service_task_execution_role.id}"
+  value       = aws_iam_role.ecs_service_task_execution_role.id
 }

 // The Amazon Resource Name (ARN) specifying the role
 output "execution_role_arn" {
   description = "IAM Role ARN for execution Role"
-  value       = "${aws_iam_role.ecs_service_task_execution_role.arn}"
+  value       = aws_iam_role.ecs_service_task_execution_role.arn
 }

 // The Amazon Resource Name (ARN) that identifies the cluster
 output "ecs_cluster_id" {
   description = "Id of the ECS Cluster"
-  value       = "${aws_ecs_cluster.ecs.id}"
+  value       = aws_ecs_cluster.ecs.id
 }

 // The name of the ECS cluster
 output "ecs_cluster_name" {
   description = "Name of the ECS Cluster"
-  value       = "${aws_ecs_cluster.ecs.name}"
+  value       = aws_ecs_cluster.ecs.name
 }

 output "log_group_arn" {
   description = "ARN of the Cloudwatch log group"
-  value       = "${aws_cloudwatch_log_group.log_group.arn}"
+  value       = aws_cloudwatch_log_group.log_group.arn
 }
+
diff --git a/fargate-cluster/variables.tf b/fargate-cluster/variables.tf
index 31c6394..1b2239c 100644
--- a/fargate-cluster/variables.tf
+++ b/fargate-cluster/variables.tf
@@ -5,10 +5,12 @@ variable "name" {

 variable "tags" {
   description = "Tags for resources"
-  default     = {}
+  default = {
+  }
 }

 variable "gdpr_delete_days" {
   description = "Clean up resources after x days"
   default     = 7
 }
+


### Upgrade module fargate-task

Now run the same for the fargate-task module

```bash
bash-4.4$ cd fargate-task
bash-4.4$ terraform 0.12upgrade
```


```diff
diff --git a/fargate-task/ecs_task.tf b/fargate-task/ecs_task.tf
index 8241c71..9a0bc0d 100644
--- a/fargate-task/ecs_task.tf
+++ b/fargate-task/ecs_task.tf
@@ -1,60 +1,64 @@
 //  Task Definition, fargate only
 resource "aws_ecs_task_definition" "task" {
-  family = "${var.family}"
+  family = var.family

-  task_role_arn            = "${aws_iam_role.ecs_service_task_role.arn}"
+  task_role_arn            = aws_iam_role.ecs_service_task_role.arn
   network_mode             = "awsvpc"
   requires_compatibilities = ["FARGATE"]
-  cpu                      = "${var.cpu}"
-  memory                   = "${var.memory}"
-  execution_role_arn       = "${var.task_execution_role}"
+  cpu                      = var.cpu
+  memory                   = var.memory
+  execution_role_arn       = var.task_execution_role

-  container_definitions = "${data.template_file.task_definition.rendered}"
+  container_definitions = data.template_file.task_definition.rendered
 }

 # Specify the family to find the latest ACTIVE revision in that family.
 data "aws_ecs_task_definition" "task" {
-  task_definition = "${aws_ecs_task_definition.task.family}"
+  task_definition = aws_ecs_task_definition.task.family

-  depends_on = ["aws_ecs_task_definition.task"]
+  depends_on = [aws_ecs_task_definition.task]
 }

 // ECS Service
 resource "aws_ecs_service" "service" {
-  name        = "${var.family}"
-  cluster     = "${var.cluster_name}"
+  name        = var.family
+  cluster     = var.cluster_name
   launch_type = "FARGATE"

   // Networkconfiguration onlu required for awsvpc networking
   network_configuration {
-    subnets          = "${var.subnet_ids}"
-    security_groups  = "${var.security_group_ids}"
-    assign_public_ip = "${var.assign_public_ip}"
+    subnets          = var.subnet_ids
+    security_groups  = var.security_group_ids
+    assign_public_ip = var.assign_public_ip
   }

-  desired_count = "${var.desired_count}"
+  desired_count = var.desired_count

   // Retrieve the latest revision number from AWS.
   // When running a deploy it will show a change in the plan
   // But since there is no actual change there is no action executed by the aws api
-  task_definition = "${var.family}:${max(aws_ecs_task_definition.task.revision, data.aws_ecs_task_definition.task.revision)}"
+  task_definition = "${var.family}:${max(
+    aws_ecs_task_definition.task.revision,
+    data.aws_ecs_task_definition.task.revision,
+  )}"

-  depends_on = ["aws_ecs_task_definition.task"]
+  depends_on = [aws_ecs_task_definition.task]
 }

 // Create a task definition from the json template file
 data "template_file" "task_definition" {
-  template = "${file("${path.module}/task_definition.json")}"
+  template = file("${path.module}/task_definition.json")

   vars = {
-    cpu           = "${var.cpu}"
-    mem           = "${var.memory}"
-    image         = "${var.image}"
-    service_name  = "${var.service}"
-    cluster_name  = "${var.cluster_name}"
-    region        = "${var.aws_region}"
-    hostport      = "${var.host_port}"
-    containerport = "${var.container_port}"
-    log_group     = "${element(split(":",var.log_group_arn),6)}"
+    cpu           = var.cpu
+    mem           = var.memory
+    image         = var.image
+    service_name  = var.service
+    cluster_name  = var.cluster_name
+    region        = var.aws_region
+    hostport      = var.host_port
+    containerport = var.container_port
+    log_group     = element(split(":", var.log_group_arn), 6)
   }
 }
+
diff --git a/fargate-task/iam.tf b/fargate-task/iam.tf
index 43f5e68..6c010db 100644
--- a/fargate-task/iam.tf
+++ b/fargate-task/iam.tf
@@ -2,7 +2,7 @@
 resource "aws_iam_role" "ecs_service_task_role" {
   name_prefix = "EcsTask-${var.cluster_name}-"

-  assume_role_policy = "${data.aws_iam_policy_document.ecs_service_task_role_assume.json}"
+  assume_role_policy = data.aws_iam_policy_document.ecs_service_task_role_assume.json
 }

 data "aws_iam_policy_document" "ecs_service_task_role_assume" {
@@ -15,3 +15,4 @@ data "aws_iam_policy_document" "ecs_service_task_role_assume" {
     }
   }
 }
+
diff --git a/fargate-task/output.tf b/fargate-task/output.tf
index 30aa43c..12f81ec 100644
--- a/fargate-task/output.tf
+++ b/fargate-task/output.tf
@@ -1,19 +1,20 @@
 output "task_iam_role_id" {
   description = "Id of the iam role for the task"
-  value       = "${aws_iam_role.ecs_service_task_role.id}"
+  value       = aws_iam_role.ecs_service_task_role.id
 }

 output "task_iam_role_arn" {
   description = "ARN of the iam role for the task"
-  value       = "${aws_iam_role.ecs_service_task_role.arn}"
+  value       = aws_iam_role.ecs_service_task_role.arn
 }

 output "task_definition_arn" {
   description = "Id of the task definition"
-  value       = "${aws_ecs_task_definition.task.arn}"
+  value       = aws_ecs_task_definition.task.arn
 }

 output "task_definition_id" {
   description = "ARN of the task definition"
-  value       = "${aws_ecs_task_definition.task.id}"
+  value       = aws_ecs_task_definition.task.id
 }
+
diff --git a/fargate-task/system.tf b/fargate-task/system.tf
index 4be8195..417bdf5 100644
--- a/fargate-task/system.tf
+++ b/fargate-task/system.tf
@@ -1,5 +1,8 @@
 # Global Aws data resources
-data "aws_region" "current" {}
+data "aws_region" "current" {
+}

 #https://www.terraform.io/docs/providers/aws/d/caller_identity.html
-data "aws_caller_identity" "current" {}
+data "aws_caller_identity" "current" {
+}
+
diff --git a/fargate-task/variables.tf b/fargate-task/variables.tf
index cabf11f..ef1b37c 100644
--- a/fargate-task/variables.tf
+++ b/fargate-task/variables.tf
@@ -1,16 +1,16 @@
 variable "service" {
   description = "Name of the service to be created"
-  type        = "string"
+  type        = string
 }

 variable "family" {
   description = "Name of the family to be created"
-  type        = "string"
+  type        = string
 }

 variable "cluster_name" {
   description = "Name of the ecs cluster for the task"
-  type        = "string"
+  type        = string
 }

 variable "cpu" {
@@ -25,7 +25,7 @@ variable "memory" {

 variable "image" {
   description = "Path of docker image including tag"
-  type        = "string"
+  type        = string
 }

 variable "host_port" {
@@ -43,17 +43,19 @@ variable "desired_count" {
   default     = 1
 }

-variable "task_execution_role" {}
+variable "task_execution_role" {
+}

-variable "aws_region" {}
+variable "aws_region" {
+}

 variable "subnet_ids" {
-  type    = "list"
+  type    = list(string)
   default = []
 }

 variable "security_group_ids" {
-  type    = "list"
+  type    = list(string)
   default = []
 }

@@ -61,8 +63,11 @@ variable "assign_public_ip" {
   default = false
 }

-variable "log_group_arn" {}
+variable "log_group_arn" {
+}

 variable "tags" {
-  default = {}
+  default = {
+  }
 }
+
```

### Upgrade main directory:

Let's now run the upgrade on our main directory

```bash
bash-4.4$ terraform 0.12upgrade

Error: Module already upgraded

  on terraform.tf line 31, in terraform:
  31:   required_version = ">= 0.12"

The module in directory . has a version constraint that suggests it has
already been upgraded for v0.12. If this is incorrect, either remove this
constraint or override this heuristic with the -force argument. Upgrading a
module that was already upgraded may change the meaning of that module.
```

In the begining when changing the provider version i also updated the terraform version.
Change `terraform.tf` and set version to 0.11, and run again :

```
Crash:

-----------------------------------------------------------------------------
panic: HEREDOC not supported yet

goroutine 1 [running]:
```

There is a problem with HEREDOC notation and the upgrade the tool. Workaround for now is either
extract the code to a json file and include with file("my.json") or change to data aws_iam_policy_document
I did the later and ran the upgrade command again.


`terraform 0.12upgrade`

```diff
diff --git a/dynamodb.tf b/dynamodb.tf
index 7855b54..6ff21ad 100644
--- a/dynamodb.tf
+++ b/dynamodb.tf
@@ -21,3 +21,4 @@ resource "aws_dynamodb_table" "basic-dynamodb-table" {
    Environment = "demo"
  }
}
+
diff --git a/ecr.tf b/ecr.tf
index d5c8bd3..8db87e2 100644
--- a/ecr.tf
+++ b/ecr.tf
@@ -1,8 +1,9 @@
// Create Repository and output it to console
resource "aws_ecr_repository" "registry" {
-  name = "${var.ecr_repository_name}"
+  name = var.ecr_repository_name
}

output "ecr_url" {
-  value = "${aws_ecr_repository.registry.repository_url}"
+  value = aws_ecr_repository.registry.repository_url
}
+
diff --git a/ecs_task.tf b/ecs_task.tf
index 25e3583..ab7c2c3 100644
--- a/ecs_task.tf
+++ b/ecs_task.tf
@@ -1,39 +1,39 @@
// Use cluster module to create the Cluster
-module ecs_cluster {
+module "ecs_cluster" {
  source = "./fargate-cluster"
-  name   = "${var.ecs_cluster_name}"
+  name   = var.ecs_cluster_name
}

// use task module to create the fargate task
module "ecs_task" {
  source              = "./fargate-task"
-  task_execution_role = "${module.ecs_cluster.execution_role_arn}"
-  service             = "${var.ecs_task["service"]}"
-  family              = "${var.ecs_task["family"]}"
-  cpu                 = "${var.ecs_task["cpu"]}"
-  memory              = "${var.ecs_task["memory"]}"
-  desired_count       = "${var.ecs_task["desired_count"]}"
+  task_execution_role = module.ecs_cluster.execution_role_arn
+  service             = var.ecs_task["service"]
+  family              = var.ecs_task["family"]
+  cpu                 = var.ecs_task["cpu"]
+  memory              = var.ecs_task["memory"]
+  desired_count       = var.ecs_task["desired_count"]
  image               = "${aws_ecr_repository.registry.repository_url}:latest"
-  host_port           = "${var.ecs_task["host_port"]}"
-  container_port      = "${var.ecs_task["container_port"]}"
-  cluster_name        = "${var.ecs_cluster_name}"
+  host_port           = var.ecs_task["host_port"]
+  container_port      = var.ecs_task["container_port"]
+  cluster_name        = var.ecs_cluster_name

-  aws_region         = "${data.aws_region.current.name}"
-  subnet_ids         = "${data.aws_subnet_ids.default.ids}"
-  security_group_ids = ["${aws_security_group.ecs_demo.id}"]
+  aws_region         = data.aws_region.current.name
+  subnet_ids         = data.aws_subnet_ids.default.ids
+  security_group_ids = [aws_security_group.ecs_demo.id]
  assign_public_ip   = true
-  log_group_arn      = "${module.ecs_cluster.log_group_arn}"
+  log_group_arn      = module.ecs_cluster.log_group_arn
}

// SG For the Task, opens the container port to the world
resource "aws_security_group" "ecs_demo" {
  name   = "SGECS-${var.ecs_cluster_name}-${var.ecs_task["service"]}"
-  vpc_id = "${data.aws_vpc.default.id}"
+  vpc_id = data.aws_vpc.default.id

  # allow all open for now
  ingress {
-    from_port   = "${var.ecs_task["host_port"]}"
-    to_port     = "${var.ecs_task["host_port"]}"
+    from_port   = var.ecs_task["host_port"]
+    to_port     = var.ecs_task["host_port"]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
@@ -49,9 +49,9 @@ resource "aws_security_group" "ecs_demo" {
// additional policy for the task to access dynamodb
resource "aws_iam_role_policy" "ecs_task_allow_dynamodb_demo" {
  name = "ecs-allow-dynamodb-demo"
-  role = "${module.ecs_task.task_iam_role_id}"
+  role = module.ecs_task.task_iam_role_id

-  policy = "${data.aws_iam_policy_document.ecs_task_allow_dynamodb_demo_policy.json}"
+  policy = data.aws_iam_policy_document.ecs_task_allow_dynamodb_demo_policy.json
}

data "aws_iam_policy_document" "ecs_task_allow_dynamodb_demo_policy" {
@@ -82,7 +82,8 @@ data "aws_iam_policy_document" "ecs_task_allow_dynamodb_demo_policy" {
      "dynamodb:PutItem",
    ]
    resources = [
-      "${aws_dynamodb_table.basic-dynamodb-table.arn}",
+      aws_dynamodb_table.basic-dynamodb-table.arn,
    ]
  }
}
+
diff --git a/service_role.tf b/service_role.tf
index 2c8d6b7..72f3e08 100644
--- a/service_role.tf
+++ b/service_role.tf
@@ -6,3 +6,4 @@
resource "aws_iam_service_linked_role" "ecs" {
  aws_service_name = "ecs.amazonaws.com"
}
+
diff --git a/terraform.tf b/terraform.tf
index ddc19bd..c6d1a57 100644
--- a/terraform.tf
+++ b/terraform.tf
@@ -1,8 +1,10 @@
# Global Aws data resources
-data "aws_region" "current" {}
+data "aws_region" "current" {
+}

#https://www.terraform.io/docs/providers/aws/d/caller_identity.html
-data "aws_caller_identity" "current" {}
+data "aws_caller_identity" "current" {
+}

// retrieve Default VPC information
data "aws_vpc" "default" {
@@ -11,7 +13,7 @@ data "aws_vpc" "default" {

// retreive subnets-ids for default VPC
data "aws_subnet_ids" "default" {
-  vpc_id = "${data.aws_vpc.default.id}"
+  vpc_id = data.aws_vpc.default.id
}

# // retreive subnets for default VPC
@@ -29,7 +31,6 @@ provider "aws" {
# an error is shown
terraform {
  required_version = ">= 0.11"
-
  #  backend          "s3"             {}
}

diff --git a/variables.tf b/variables.tf
index 9332ca9..7ebcb9d 100644
--- a/variables.tf
+++ b/variables.tf
@@ -22,3 +22,4 @@ variable "ecs_task" {
    container_port = 8080
  }
}
+
```

We now have our code partly upgraded to version 0.12 HCL2. The plan is the same as before the code changes.
Next steps utility the new possibilities there are, like returning full objects and complex data types.
