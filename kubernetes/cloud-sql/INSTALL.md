# Create CloudSQL secret
kubectl create secret generic cloudsql-proxy-sa-key \
  --from-file=key.json=key.json