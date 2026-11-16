# Troubleshooting notes

Record every real problem you hit: what you saw, what caused it, how you fixed it, and a screenshot of the error.

| Date | Symptom | Cause | Fix | Evidence |
| --- | --- | --- | --- | --- |
| TODO | | | | |

## Common issues with this setup

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| `AccessDenied` at the bare cloudfront.net address | Default root object not set | Set it to `index.html` |
| `AccessDenied` on every page | Bucket policy missing or wrong distribution ID in `AWS:SourceArn` | Re-apply the OAC bucket policy |
| `AccessDenied` even with the right policy | Origin is the S3 website endpoint | Use the `bucket.s3.us-east-1.amazonaws.com` REST endpoint |
| Old content after an upload | Edge still caching the old copy | Invalidate `/*` |
| Icons, fonts or previews missing after adding headers | CSP blocks a source | Read browser Console errors; add the domain to the CSP |
| "Could not load credentials from any providers" | `id-token: write` permission missing | Add the `permissions` block to the workflow |
| "Not authorized to perform sts:AssumeRoleWithWebIdentity" | Trust policy `sub` or `aud` mismatch | Check `repo:mbeeudo/<repo>:ref:refs/heads/main` and `sts.amazonaws.com` |
| `s3 sync` AccessDenied | No `s3:ListBucket` on the bucket ARN | Add the ListBucket statement |
| No CloudFront metrics or alarms | Console in another region | Switch to us-east-1 |
| LinkedIn shows no preview | `og:image` placeholder or cached preview | Fix tags, redeploy, re-scrape in LinkedIn Post Inspector |
