# Configuration decisions

| Decision | Choice | Why | Alternative considered |
| --- | --- | --- | --- |
| Region | us-east-1 | CloudFront metrics, alarms and ACM certificates live there; one region to manage | Region closest to me (edge locations serve visitors either way) |
| Origin access | OAC with the S3 REST endpoint | Bucket stays fully private | S3 static website hosting, which needs a public bucket |
| Bucket policy scope | `AWS:SourceArn` = my distribution | Stops any other distribution reading the bucket | Allowing the CloudFront service principal without a condition |
| Encryption at rest | SSE-S3 | Free, automatic, no key policy needed for CloudFront | SSE-KMS (needs KMS key policy for CloudFront) |
| Versioning | On | Roll back a bad deploy | Off |
| Viewer protocol | Redirect HTTP to HTTPS, plus HSTS | No plain-text traffic | HTTPS only (rejects instead of redirecting) |
| Cache policy | CachingOptimized | Sensible TTLs, respects Cache-Control | Custom policy |
| HTML caching | `no-cache` | Visitors always get the latest content | Long TTL plus invalidation only |
| Asset caching | `max-age=86400` | Images rarely change | Longer TTLs with versioned file names |
| Price class | North America, Europe, Asia, Middle East and Africa | Serves Nigerian visitors from African edge locations | Price Class (CloudFront Free flat-rate plan: $0 a month, covers this site traffic) |
| CI/CD credentials | GitHub OIDC | No long-lived keys to leak or rotate | IAM user access keys in GitHub secrets |
| CSP | Allows `'unsafe-inline'` | Page uses inline styles and scripts | Move to external files and drop `'unsafe-inline'` (planned) |
| WAF | Not enabled | Cost for a personal static site | Rate-based rule + managed common rule set |

TODO: add any decision you made differently, and why.
