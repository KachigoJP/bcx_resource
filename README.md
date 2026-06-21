# bcx_resource

# Kubernets Command
gcloud container clusters get-credentials bcx-cluster --region us-central1 --project banchanxanh
gcloud container clusters get-credentials bcx-cluster --region us-central1
kubectl rollout restart deployment bcx-strapi-prod
kubectl exec -it bcx-strapi-prod-bd47d7c5f-znljx -- env
kubectl exec -it bcx-strapi-prod-bd47d7c5f-znljx -- cat ./config/server.ts

# Kustomize
kubectl kustomize banchanxanh/bcx-strapi/dev > final-dev.yaml
kubectl kustomize banchanxanh/overlays/prod
kubectl apply -k banchanxanh/overlays/dev
kubectl apply -k banchanxanh/overlays/prod

kubectl get secret bcx-strapi-secret-prod -o go-template='{{.data.TRANSFER_TOKEN_SALT | base64decode}}'
kubectl get configmap bcx-hp-host-config-prod -o go-template='{{.data.GOOGLE_CLIENT_ID}}'

