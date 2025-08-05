# Elastic Load Balancer - AWS

## What is it?
Elastic Load Balancer (ELB) automatically distributes incoming network or application traffic across multiple targets (such as EC2 instances) in one or more Availability Zones (AZs). It helps ensure fault tolerance, scalability, and high availability.

## Key Concepts
- ***Load Balancer***: Routes traffic across healthy targets.
- ***Target Group***: A collection of targets (like EC2s) to which traffic is sent.
- ***Health Check***: Verifies target availability and health.
- ***Listeners***: Define protocol and port mapping for incoming traffic
- ***Sticky Sessions (Session Affinity)***: Keep a user connected to the same target using cookies (available in ALB/CLB).
- ***Connection Draining***: Allows ongoing requests to complete before removing targets from service.
- ***Cross-Zone Load Balancing***: Distributes traffic evenly across all targets in all AZs.
- ***Availability Zones (AZ)***: ELB can span multiple AZs for redundancy.

## Components
- ***Application Load Balancer (ALB)***: Layer 7 (HTTP/HTTPS); supports advanced routing (URL path, host, headers)
- ***Network Load Balancer (NLB)***: Layer 4 (TCP/UDP): designed for ultra-low latency and static IPs.
- ***Gateway Load Balancer (CLB)***: Routes traffic to third-party applicances like firewalls.
- ***Classic Load Balancer (CLB)***: Legacy; supports basic L4 and L7 features (not recommended for new apps)

## Use Cases
- Distributting traffic to EC2 web servers.
- Routing requests to microservices (ALB).
- Load balancing TCP traffic for high-performing apps (NLB)
- Deployments using blue/green or canary patterns.

## How it works (basic flow)
### 1. Create an ALB (Application Load Balancer)

#### a. Basic Configuration
- Name: `my-app-alb`
- Scheme: **Internet-facing**
- IP Address Type: **IPv4**

#### b. Network Mapping
- Choose **at least 2 Availability Zones** for high availability.

#### c. Security Groups
- Create a new Security Group:
  - Name: `alb-sg`
  - Description: `Allow HTTP traffic`
  - VPC: Default (or select your custom VPC)
- Inbound Rules:
  - Type: **HTTP**
  - Protocol: **TCP**
  - Port: **80**
  - Source: `0.0.0.0/0` (public access)

### 2. Configure Listeners and Target Group

#### a. Create Target Group
- Target Type: **Instances**
- Name: `my-app-targets`
- Protocol: **HTTP**, Port: **80**
- VPC: Same as your ALB
- Protocol Version: HTTP1

#### b. Health Check Settings
- Protocol: **HTTP**
- Path: `/`
- Port: **Traffic Port**

#### c. Register Targets
- Select your EC2 instances
- Specify port **80**
- Click **Register** → Continue

#### d. Finalize Listener
- Listener: HTTP on port 80 → Forward to the new target group

### 3. Launch the Load Balancer
- Review settings
- Click **Create Load Balancer**

## Security Notes
- Use Security Groups (ALB/CLB)
- Use Https listeners + ACM LTS certificates for secure connections
- IAM policies control who can manage/load balancers
- ALB supports WAF (Web application firewall) integration

## Questiuon to Ask Yourself

- When should I use ALB vs NLB
- How does connection draining improve deployments?
- What are the limitations of sticky sessions?
- How does cross-zone load balancing affect traffic and cost?
- Can I load balance Lambda functions or containers?

## Notes & Gotchas
- **Sticky sessions** are useful but can cause uneven load and are not supported in NLB.
- **Cross-zone balancing** is off by default for NLB and free for ALB.
- Without proper health checks, all traffic may go to unhealthy targets.
- ALB supports host/path-based routing (e.g. `/api`, `/admin`, etc.).
- NLB supports static IPs and TLS termination, but has limited routing logic.
- CLB is deprecated; avoid using it in new designs.
- Connection draining is critical during scale-in to avoid dropping active users.