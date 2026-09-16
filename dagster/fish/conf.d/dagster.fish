set -gx DAGSTER_CLOUD_ORGANIZATION poolside
set -gx DAGSTER_CLOUD_API_TOKEN (security find-generic-password -w -s dagster-cloud -a $USER 2>/dev/null)
