# Relational Database Service (RDS) - AWS

## What is it?
Amazon RDS (Relational Database Service) is a managed service that makes it easy to set up, operate, and scale relational database in the cloud. It automates tasks like backups, patching, provisioning, and monitoring for databases such as MySQL, PostgreSQL, MariaDB, SQL Server, and Amazon Aurora.

## Key Concepts
- ***DB Instance***: A managed databse server with a specific engine, size and configuration.
- ***Multi-AZ Deployment***: Provides high availability by atuomatically replicating data to a standby in a different AZ.
- ***Read Replica***: A read-only copy of a DB instance used for horizontal scaling.
- ***Parameter Groups***: Configuration settings for database engine behavior.
- ***Subnet Group***: Defines which subnets within a VPC the database can run in.

## Components
- [Component Name]: What is it used for?
- [Component Name]: Any limitations?

## Use Cases
- Hosting production-grade relational databases with automated backups and scaling.
- Offloading read traffic using read replicas.
- Migration on-prem databases to cloud-managed RDS instances.

## How it works (basic flow)
1. Once in the RDS service, click on Create database button
2. For Choose a database creation method, choose Standard create
3. For engine options, choose MySQL and then the version
4. then for template choose production
5. For availability and durability, choose single DB instance
6. For settings, provide a DB instance identifier, a username and password for the credentials.
7. For Instance configuration, choose Burstable classes option and db.t3.micro
8. For storage choose General Purpose SSD gp2 and 20GB for allocated storage
9. For connectivity choose Don't connect to an EC2 compute resource option, choose the VPC, enable public access, and create a new security group
10. For database authentication, choose password authentication
11. Disable monitoring
12. for Additional configuration, provide a initial database name, 
13. Create database

## Security Notes
- [Example: Uses IAM roles, security groups, etc.]

## Question to Ask Yourself

- What problems does this service solves?
- When would I use this over another AWS service?
- Can I explain it to someone in one minute?
- What's the cost model (free tier, pay-per-use, etc.)?

## Notes & Gotchas
- [Weird behavior, limitations, common mistakes, exam tips]

## Extra (optional)
- CLI commands / Console tricks
- Pricing Tips
- Hands-on reminders
- Terraform Implementation