# 1. Use "Mount EBS Volume To EC2-XFS Filesystem-persistent.sh" script for mount external volume for kafka logs
# 2. When our volume 100% used then out kafka brokers will be down.
################## Extend Volume and Restart Kakfa ######################
# 3. Go to AWS Console and "Modify Volume" for increase size
# 4. backup every broker's data 
# 5. use below command for "xfs" file system for FileSystem Resize
syntax:- sudo xfs_growfs /path/to/mounted/volume
example: - sudo xfs_growfs /external-volume
# 6. Do the step no. 5 for every broker
# 7. Restart all brokers one by one
############### Monitor #################
Make sure to setup monitor machine for easy to use and understand Backend works
eg:- Prometheus, Grafana, Node Exporter, Kafka Manager and whatever you needed
