export HARBOR_REDIS_PASSWORD='TYJvB5YzR0wFRqgh8VZcIaXtlsZyHQ'
kubectl apply -f secret.yaml

helm upgrade --install harbor harbor/harbor \
  --namespace harbor \
  --create-namespace \
  -f harbor.yaml \
  --set redis.external.password="$HARBOR_REDIS_PASSWORD" \
  --set harborAdminPassword=';=Q0bna-UaFkH0i1A<<b;G-{'
  --wait

kubectl apply -f services.yaml
