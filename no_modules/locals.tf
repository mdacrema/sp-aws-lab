# locals {
#   name   = var.project
#   region = var.region

#   home_ip = var.home_ip
#   tags = [
#     {
#       key                 = "Lab"
#       value               = var.project
#       propagate_at_launch = true
#     },
#     {
#       key                 = "TerraformManaged"
#       value               = "true"
#       propagate_at_launch = true
#     },
#   ]
#   tags_as_map = {
#     Environment = "satispay-lab"
#   }

#   user_data = <<-EOT
#   #!/bin/bash
#   sudo yum -y install httpd mariadb-server tomcat && systemctl start mariadb httpd tomcat && systemctl enable mariadb httpd tomcat
#   EOT
# }