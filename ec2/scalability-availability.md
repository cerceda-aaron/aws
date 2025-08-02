## Scalability & High Availability

- Scalability means that an application / system can handle greater loads by adapting.
- There are two kinds of scalability:
    - Vertical Scalability
    - Horizontal Scalability (= elasticity)
- Scalability is linked but different to High Availability.

## Vertical Scalability

- Vertically scalability means increasing the size of the instance
- For example, your application runs on a t2.micro
- scaling that application vertically means running it on a t2.large
- Vertical scalability is very common for non distributed systems, such a database.
- RDS, ElastiCache are services that can scale vertically.
- There's usually a limit to how much you can vertically scale (hardware limit)

## Horizontal Scalability

- Horizontal Scalability means increasing the number of instances/systems for your application.
- Horizontal scaling implies distributed systems.
- This is very common for web applications / modern applications
- It's easy to horizontal scale thanks the cloud offerings such as Amazon EC2


## High Availability

- High Availability usually goes hand in hand with horizontal scaling.
- High availability means running your application/system in at least 2 data center (== Availability Zones)

- The goal of high availability is to survive a data center loss
- The high availability can be passive (for RDS Multi AZ for example)

- The high availability can be active (for horizontal scaling)

## High Availability & Scalability For EC2

- Vertical Scaling: Increase instance size ( = scale up / down)
    - from t2.micro - 0.5 of ram, 1 vCPU
    - to u-2tbl.metal - 12.3 TB of Ram, 448 vCPUs

- Horizontal Scaling: increase number of instances (= scale out / in)
    - Auto Scaling Group
    - Load Balancer

- High Availability: Run instances for the same applications across multi AZ
    - Auto Scaling group multi AZ
    - Load balancer multi AZ