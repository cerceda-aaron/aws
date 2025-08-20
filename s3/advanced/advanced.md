Amazon S3 - Moving between Storage Classes

- You can transition objects between storage classes
- For infrequently accessed objects, move them to Standard IA
- For archive objects that you don't need fast access to, move them to Glacier or Glacier Deep Archive
- Moving objects can be automated using lifecycle rules

Storage classes

- Standard 
    - Use case: Frequently accessed data (e.g. websites, apps, hot backups)
    - Features: High durability, availability, and performance.
    - Cost: Most expensive per GB, but no retrieval fees.

- Standard IA
    - Use case: Data accessed less often but still needs to be quickly retrieved (e.g. backups, disaster recovery)
    - Features: Lower storage cost, but you pay a fee each time you retrieve data

- Intelligent Tiering
    - Use case: Data with unpredictable access patterns
    - Features: Automatically moves objects between tiers (frequent/infrequent access) based on usage.
    - Cost: Small monthly monitoring fee, but can save money over time

- One-Zone IA
    - Use case: Infrequently accessed data that doesn't require multiple availability zone resilience
    - Features: Same performance as Standard IA but stored in a single AZ (20% cheaper than Standard IA)
    - Cost: Lower cost than Standard IA, but data is lost if the AZ is destroyed

- Glacier Instant Retrieval
    - Use case: Archive data that is rarely accessed but needs millisecond retrieval when needed
    - Features: Minimum storage duration of 90 days
    - Cost: Lower storage cost than Standard IA, retrieval cost per GB

- Glacier Flexible Retrieval
    - Use case: Archive data that doesn't need immediate access
    - Features: Minimum storage duration of 90 days, retrieval options: Expedited (1-5 min), Standard (3-5 hours), Bulk (5-12 hours)
    - Cost: Very low storage cost, pay per retrieval

- Glacier Deep Archive
    - Use case: Long-term archive and digital preservation for data accessed once or twice per year
    - Features: Minimum storage duration of 180 days, retrieval options: Standard (12 hours), Bulk (48 hours)
    - Cost: Lowest storage cost, highest retrieval cost and time

## Lifecycle Rules

Lifecycle rules allow you to automatically transition objects between storage classes or delete them after a certain period.

### Common Lifecycle Transitions
1. Standard → Standard IA (after 30 days)
2. Standard IA → Glacier Instant Retrieval (after 60 days)
3. Glacier Instant Retrieval → Glacier Flexible Retrieval (after 90 days)
4. Glacier Flexible Retrieval → Glacier Deep Archive (after 180 days)

### Rules
- Objects must stay in Standard for at least 30 days before transitioning to Standard IA
- Objects must stay in Standard IA for at least 30 days before transitioning to Glacier
- You can transition directly from Standard to any other class
- Small objects (<128KB) are not cost-effective for IA, Glacier classes due to minimum billable object size