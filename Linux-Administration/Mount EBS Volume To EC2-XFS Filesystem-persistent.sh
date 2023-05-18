# Mount EBS Volume on EC2 Instance Persistent for Kafka
# This is xfs filesystem type volume mount which is used by kafka
# Create volume and attach with ec2 isntance

# Step 1: Now, ssh to your ec2 instance and list the available disks using the following command.

 lsblk

# Step 2: Check if the volume has any data using the following command.

sudo file -s /dev/xvdf

# If the above command output shows “/dev/xvdf: data“, it means your volume is empty.

# Step 3: Format the volume to the xfs filesystem using the following command.
          # We can use another file system as per our need i.e. xfs, ext4, btrfs, zfs


sudo mkfs.xfs /dev/xvdf

# Step 4: Create a directory of your choice to mount our new ext4 volume. I am using the name “data“. You can name it something meaningful to you.

sudo mkdir /external-volume

# Step 5: Mount the volume to the directory you created.

# Step 6: Mount the volume to “data” directory using the following command.

sudo mount /dev/xvdf /external-volume

# Step 7: cd into data directory and check the disk space to validate the volume mount.

# cd /external-volume
# df -h .  

#or

df -h /external-volume

# Step 8: unmount the volume then you can use below command and verify using lsblk command

sudo umount /dev/xvdf
lsblk

#-----------Automount EBS volume on Reboot. Make persistent mounted volume------------------

# Step 9: Back up the /etc/fstab file if encounter any kind of error we will restore it.

sudo cp -v /etc/fstab /etc/fstab.bak

# Step 10: Open /etc/fstab file and make an entry in the following format.
        # device_name mount_point file_system_type fs_mntops fs_freq fs_passno

 # Example: /dev/xvdf       /external-volume   xfs    defaults        0       0

 # Then save and close the file or you can use below command to append this line direct into /etc/fstab file

echo "/dev/xvdf  /external-volume  xfs  defaults  0  0" | sudo tee -a /etc/fstab

# Step 11: Execute the following command to check if the fstab file has any errors.

sudo mount -a

# If the above command shows no error, it means our fstab entry is valid.

# Step 12: Check and verify mounted volume

lsblk

# Step 13: For give permission for user to this directory

sudo chown -R ec2-user:ec2-user /external-volume

df -h /external-volume

ls -l /external-volume

# Now, on every reboot, the extra EBS volumes will get mounted automatically.

#----------------------------------------------------------------------------

# Important Informations:

# xfs:

# When it comes to choosing a filesystem for Apache Kafka, the recommended filesystem type is XFS. XFS is known for its high performance and scalability, which aligns well with the requirements of a high-throughput messaging system like Kafka. XFS provides excellent performance for both read and write operations, handles large file sizes efficiently, and performs well with concurrent access patterns. Using XFS with Kafka is beneficial because:

# 1. Performance: XFS is optimized for high-performance workloads and can handle large numbers of read and write operations efficiently. Kafka requires a filesystem that can handle high throughput and low latency, and XFS excels in this regard.

# 2. Scalability: XFS is designed to scale well with large storage devices and high-volume workloads. As Kafka deals with large amounts of data, XFS can handle the scaling requirements and grow as your data grows.

# 3. Journaling: XFS provides journaling capabilities, which help ensure data consistency and recoverability in case of unexpected system failures or crashes. Kafka relies on filesystem durability, and XFS journaling enhances the reliability of data storage.

# 4. Reliability: XFS has a reputation for being a reliable and stable filesystem. It has been extensively used in production environments and has proven to be robust and dependable.

# While XFS is the recommended choice, it's worth noting that other filesystems like ext4 and Btrfs can also be used with Kafka, depending on your specific requirements and the underlying storage infrastructure. However, XFS is widely adopted and considered a solid choice for Kafka deployments due to its performance characteristics and reliability.

# fstab:

# `fstab` stands for "file systems table" and is a configuration file used in Linux and other Unix-based operating systems to define how file systems are mounted at boot time. The `fstab` file contains information about the file systems that are mounted at boot time, including the file system type, mount point, options, and other parameters.

# When the Linux operating system boots up, it reads the `fstab` file to determine which file systems need to be mounted, and how they should be mounted. The `fstab` file is located in the `/etc` directory and is usually edited by system administrators.

# The `fstab` file can be used to mount different types of file systems, including local file systems, network file systems, and removable media such as USB drives. By default, most Linux distributions will create an `fstab` file during installation that includes entries for all of the file systems that are expected to be mounted at boot time.

# The `fstab` file is an important configuration file in Linux, and it is important to ensure that it is correctly configured to avoid any issues with mounting file systems at boot time.

#----------------------------------------------------------------------------

# mkfs:

# In the context of the `mkfs` command, the `-t` option is used to specify the type of filesystem to be created on the given device. In this specific command, `-t ext4` specifies that the `ext4` filesystem type should be used.

# The `mkfs` command is used to create a filesystem on a device (such as a hard disk or USB drive) so that it can be used to store files and directories. The `/dev/xvdf` argument specifies the device that the filesystem should be created on. The `sudo` command is used to run the `mkfs` command with administrative privileges.
