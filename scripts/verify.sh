#!/usr/bin/env bash
# Checks the live deployment. Usage: ./scripts/verify.sh d1234abcd.cloudfront.net mbeeudo-static-site-2026
set -u
CF="${1:?CloudFront domain, e.g. d1234abcd.cloudfront.net}"
BUCKET="${2:?bucket name}"
REGION="${3:-us-east-1}"

echo "== 1. HTTP redirects to HTTPS (expect 301)"
curl -sI "http://$CF/" | head -1

echo; echo "== 2. HTTPS works (expect 200)"
curl -sI "https://$CF/" | head -1

echo; echo "== 3. Security headers"
curl -sI "https://$CF/" | grep -iE "strict-transport|content-security|x-frame|x-content-type|referrer-policy|permissions-policy"

echo; echo "== 4. Caching: first request, then second (expect Miss or Hit, then Hit)"
curl -sI "https://$CF/og-image.jpg" | grep -iE "x-cache|^age|x-amz-cf-pop"
sleep 1
curl -sI "https://$CF/og-image.jpg" | grep -iE "x-cache|^age|x-amz-cf-pop"

echo; echo "== 5. Bucket is private (expect 403)"
curl -sI "https://$BUCKET.s3.$REGION.amazonaws.com/index.html" | head -1
