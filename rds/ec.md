# ElasticCache - AWS

## What is it?
> AWS ElasticCache isd a fully managed in-memory data store and cache service that supports Redis and Memcached. It is used to improve application performance by retrieving data from high-speed, low-latency, in-memory caches instead of relying entirely on slower disk-based database.

## Key Concepts
- ***In-Memory Store***: Data is stored in RAM, making reads and writes extremely fast.
- ***Node***: A single cache instance.
- ***Cluster***: A group of nodes. In Redis (cluster mode), shards allow for partitioning data across multiple nodes.

## Components
- ***Redis or memcached Engine***: Choose between two engines. Redis supports persistence, replication, and more features; Memcached is simpler and multi-threaded.
- ***Primary Node (Redis)***: Accepts writes and can replicate to read replicas.
- ***Read Replica (Redis only)***: Used to scale read operations and enhance availability.

## Use Cases
- ***Session storage***: Store session data for web applications.
- ***Caching database queries***: Speed up response times by caching expensive DB queries.
- ***Leaderboard/gaming***: Fast reads-writes make it ideal for real-time scores.
- ***Rate limiting***: Redis counters or sorted sets are great for this.

## How it works (basic flow)
1. Navigate to ElastiCache service in AWS and click create redis cache button
2. For configuration section, choose Design you own cache option and for creation method, choose Cluster cache
3. For cluster mode choose disable
4. in cluster info, provide a cluster name
5. for Location section, choose AWS cloud, disable multi-AZ and enable Auto-failover
6. in cluster settings choose the cache.t2.micro for the node type field and 0 replicas.
7. for Subnet group settings, provide a name
8. click next
9.  disable backup
10. click next
11. click create.

## Security Notes
- Uses VPC to control network access
- Supports IAM policies for API-level access

## Question to Ask Yourself

- Is it safe to cache data? Data may be ou tof date, eventually consistent
- Is caching effective for that data?
    - Pattern: data changing slowly, few keys are frequently needed.
    - Anti patterns: Data changing rapidly, all large key space frequently needed.
- Is data structured well for caching?
    - example: key value caching, or caching of aggregations result.
- Which caching design pattern is the most appropriate?
    - Lazy Loading / Cache-Aside / Lazy Population
        1. App tries to get data from the cache
        2. If cache hit -> return it (super fast).
        3. If cache miss -> get it from the database.
        4. Store that result in the cache (for next time).
        5. Return the result value to the user.
    - Write Through - Add or Update cache when databse is updated.
        1. App writes data (e.g. new user or update)
        2. Write to the cahe
        3. Write to the DB
        4. Done (Now, when someone reads that data, it's already in the cache (no cache miss))

## Notes & Gotchas
- Caches Events.
    - Cache Hit - The key exists in the cache and is returned immediately.
    - Cache Miss - The key doesn't exist, so the system fetches it from the original source (e.g. DB)
    - Expired Miss - They key used to exist but expired (due to TTL). Treated as a miss.
    - Eviction Miss - The key was evicted (removed) to free space. treated as a miss.
    - Stale Hit (optional) - Some systems allow returning "stale" (slightly outdated) data if it's better than failing - uncommon in basic caching.
    - Negative Cache Hit - The cache remembers that something doesn't exist (e.g., 404) so it avoids unnecessary GB hits.

## Extra (optional)
- CLI commands / Console tricks
- Pricing Tips
- Hands-on reminders
- Terraform Implementation