## What's an EBS volume?

- An EBS (Elastic Block Storage) volume is a network drive you can attach to your instance while they run.
- It allows your instances to persist data, even after their termination.
- They can only be mounted to one instance at a time (at the CCP level).
- They are bound to a specific availability zone.
- Analogy: Think of them as "network usb stick"
- Free tier: 30 GB of free EBS storage of type general purpose (SSD) or Margneitc per month.

***Note:*** CCP - Certified cloud practitioner - one EBS can be only mounted to one EC2 instassociate level (Solution Architect, Developer, SysOps): "multi-attach" feature for some EBS.

## EBS Volume

- It's a network drive (i.e. not a physical drive).
    - It uses the network to communicate the instance, which means there might be a bit of latency.

    - It can be detach from an EC2 instance and attached to another one quickly

- It's locked to an availability zone (AZ)
    - An EBS volume in us-east-1a cannot be attached to us-east-1b
    - To move a volume across, you first need to snapshot it.

- Have a provisioned capacity (size in GBS, and IOPS)
    - you get billed for all the provisioned capacity.
    - you can increase the capacity of the drive over time.

![alt text](../images/ebs-volume.png)

## EBS - Delete on Termination attribute

- Controls the EBS behavior when an EC2 instances terminates.
    - By default, the root EBS volume is deleted (attribute enabled)
    - By default, any other attached EBS volume is not deleted (attribute disabled)
- This can be controlled by the AWS console/AWS CLI
- Use case: preserve root volume when instance is terminated.

![alt text](../images/ebs-termination.png)

## EBS Snapshots

- Make a backup (snapshot) of your EBS volume at a point in time.
- Not necessary to detach volume to do snapshot, but recommended.
- Can copy snapshots across AZ or Region

![alt text](../images/ebs-snapshot.png)

## EBS Snapshots Features

- EBS Snapshot Archieve
    - Move a Snapshot to an archieve tier that is 75% cheaper.
    - Takes within 24 to 72 hours for restoring the archieve.
- Recycle Bin for EBS Snapshots.
    - Setup rules to retain deleted snapshots so you can recover them after an accidental deletion.
    - Specify retetion (from 1 dat to 1 year)
- Fast Snapshot Restore (FSR)
    - Force full initialization of snapshot to have no latency on the first use ($$$)

![alt text](../images/ebs-features.png)


## AMI Overview

- AMI = Amazon Machine Image
- AMI are customization of an EC2 instance
    - You add your own software, configuration, operating system, monitoring..
    - Faster boot/configuration time because all your software is pre-packaged
- AMI are built for a specific region (and can be copied across regions)
- You can launch EC2 instances from:
    - A public AMI: AWS provided
    - Your own AMI: you make and maintain them yourself
    - An AWS Marketplace AMI: an AMI someone else made (and potentially sells)

## AMI Process (from an EC2 instance)

- start an EC2 instance and customize it
- Stop the instance (fro data integrity)
- Build an AMI - this will also create EBS snapshots
- Launch instances from other AMIs

![alt text](../images/ebs-ami.png)

## EC2 Instacne Store

- EBS volumes are network drives with good but "limited" performance.
- If you need a high-performance hardware disk, use EC2 instance store

- Better I/O performance
- EC2 instance store lose their storage if they're stopped (ephemeral)
- Good for buffer / cache / stratch data / temporary content
- Risk of data loss if hardware fails.
- Backups and Replication are your resposability

![alt text](../images/local-ec2.png)

## EBS Volume Types




- EBS Volumes comes in 6 types
    - gp2/gp3 (SSD): General purpose SSD volume that balances price and performance for a wide variety of workloads.
    
    - io1 / io2 Block Express (SSD): Highest-performance SSD volume for mission-critial low-latency or high-throughput workloads
    
    - st 1 (HDD): low cost HDD volume design for frequently accessed, throughput    intensive workload

    - sc1 (HDD): lowest cost HDD volume design for less frequently accessed workloads.

- EBS volume are characterized in Size | throughput | IOPS (I/O Ops per sec)