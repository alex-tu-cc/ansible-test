sudo docker build -t `grep IMAGE_NAME Dockerfile | awk '{print $2}'` .
