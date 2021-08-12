  #!/bin/bash
  sudo yum -y install httpd mariadb-server tomcat && systemctl start mariadb httpd tomcat && systemctl enable mariadb httpd tomcat