# Read Full Documentation Here => https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html
# Go to amazon console and modify the volume on browser

# 1. List Block Storage devices
sudo lsblk

# 2. Grow partition here xvda is root volume name and 1 is root partition. Make sure to your volume available. 
# Make sure your root volume is not 100% full. Because if it full then it will not work.
sudo growpart /dev/xvda 1

# 3. Verify that the partition has been extended. Use the lsblk command. The partition size should now be equal to the volume size.
sudo lsblk
# 4. Get the name, size, type, and mount point for the file system that you need to extend. Use the df -hT command.
df -hT

# 5(a). [XFS file system] Use the xfs_growfs command and specify the mount point of the file system that you noted in the previous step.
sudo xfs_growfs -d /

# 5(b). Extend a file system mounted named /dev/xvda1, use the following command for ext4 file system. Here xvda1 is root filesystem
sudo resize2fs /dev/xvda1

# 6. Verify increased space
df -hT
