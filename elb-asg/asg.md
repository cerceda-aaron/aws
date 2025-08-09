# Auto Scaling Group - AWS

## What is it?
Auto Scaling Groups (ASGs) manage a group of EC2 instances by automatically scaling the number of instances up or down based on specified conditions. They help ensure high availability, fault tolerance, and cost-efficiency,

## Key Concepts
- ***Launch Template / Launch Configuration***: Defines how new EC2 instances should be launched (AMI, instance type, key pair, etc). 
- ***Scaling Policies***: Rules that determine when to add or remove instances (based on CloudWatch alarms, target tracking, etc.)
- ***Desired Capacity***: The ideal number of instances at a given time.
- ***Min/Max Capacity***: Minimum and maximum number of instances allowed in the group.
- ***Health Checks***: Mechanism (EC2 or ELB) to detect unhealthy instances and replace them.

## Components
- [Component Name]: What is it used for?
- [Component Name]: Any limitations?

## Use Cases
- Automatically handle sudden traffic spikes in a web application.
- Replace unhealthy EC2 instances without manual intervention
- Cost optimization by scaling in during low demand hours.

## How it works (Auto Scaling Groups)
1. Go to EC2 Auto Scaling service and lick Create auto scaling group button
2. Choose/Create launch template (In this case create a launch template)
3. Provide a launch template name and template version description
4. Choose an AMI (In this case you could choose Amazon Linux AWS)
5. Choose instance type (t2.micro)
6. Choose Key pair login
7. In network section create or choose a security group
8. Configure EBS in case you need it.
9. In advanced details section, scroll to user Data and paste script (This is optional, only needed for this specific scenario for testing purposes)
10. Create launch template 
11. Coming back to the auto scaling group service, choose the launch template and click next
12. In the network section choose your VPC and choose all availability zones and for AZs distribution, choose Balanced best effort
13. In Load Balancing section, choose option (in this case) Attach to an existing Load Balancer option.
14. In Attach to an existing load balancer section, choose (choose from your load balancer group option) and then select the load balancer.
15. In health checks section, check option (turn on Elastic load balancing health checks) and then click next.
16. Click next.
17. click next.
18. click next.
19. Click Create Auto Scaling group button.

## How it works (Scaling policies)
1. Once in the auto scaling group service, choose your asg and then click on Automatic Scaling tab
2. Click on Create dynamic scaling policy
3. Choose for policy type - target tracking scaling
4. Choose for scaling policy name - target tracking policy
5. For metric type choose - Average CPU utilization
6. for target value put - 40
7. Click create

## Security Notes
- [Example: Uses IAM roles, security groups, etc.]

## Questions to Ask Yourself

- What problems does this service solves?
- When would I use this over another AWS service?
- Can I explain it to someone in one minute?
- What's the cost model (free tier, pay-per-use, etc.)?

## Notes & Gotchas
- Scale out (add EC2 instances) to match an increased load
- Scale in (remove Ec2 instances) to match a decreased load
- ASG are free (you only pay for the underlying EC2 instances)

## Extra (optional)
- CLI commands / Console tricks
- Pricing Tips
- Hands-on reminders
- Terraform Implementation