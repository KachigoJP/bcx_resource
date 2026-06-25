# bcx_resource

# Kubernets Command
gcloud container clusters get-credentials bcx-cluster --region us-central1 --project banchanxanh
gcloud container clusters get-credentials bcx-cluster --region us-central1
kubectl rollout restart deployment bcx-strapi-prod
kubectl exec -it bcx-strapi-prod-bd47d7c5f-znljx -- env
kubectl exec -it bcx-strapi-prod-bd47d7c5f-znljx -- cat ./config/server.ts

# Kustomize
kubectl kustomize banchanxanh/bcx-hp-host/prod > hp-prod.yaml
kubectl kustomize banchanxanh/bcx-strapi/dev > final-dev.yaml
kubectl kustomize banchanxanh/bcx-strapi/prod > final-prod.yaml

kubectl apply -k banchanxanh/overlays/dev
kubectl apply -k banchanxanh/overlays/prod

kubectl get secret bcx-strapi-secret-prod -o go-template='{{.data.TRANSFER_TOKEN_SALT | base64decode}}'
kubectl get configmap bcx-hp-host-config-prod -o go-template='{{.data.GOOGLE_CLIENT_ID}}'
kubectl exec  bcx-strapi-prod-6fb9f54c86-5bn8j -- cat /path/to/file
kubectl exec  bcx-strapi-prod-6fb9f54c86-5bn8j -- cat ./config/plugin.ts

# Strapi Backblaze B2 uploads

Backblaze B2 works through Strapi's official S3 upload provider. Add the provider to the Strapi app image:

```sh
npm install @strapi/provider-upload-aws-s3 --save
```

Then configure `config/plugins.ts` in the Strapi app:

```ts
export default ({ env }) => ({
  upload: {
    config: {
      provider: "aws-s3",
      providerOptions: {
        s3Options: {
          credentials: {
            accessKeyId: env("S3_ACCESS_KEY_ID"),
            secretAccessKey: env("S3_ACCESS_SECRET"),
          },
          region: env("S3_REGION"),
          endpoint: env("S3_ENDPOINT"),
          forcePathStyle: env.bool("S3_FORCE_PATH_STYLE", false),
          params: {
            ACL: env("S3_ACL", "public-read"),
            signedUrlExpires: env.int("S3_SIGNED_URL_EXPIRES", 900),
            Bucket: env("S3_BUCKET"),
          },
        },
      },
      actionOptions: {
        upload: {},
        uploadStream: {},
        delete: {},
      },
    },
  },
});
```

Set these ConfigMap values in `kubernetes/banchanxanh/bcx-strapi/dev/config.yaml` and `kubernetes/banchanxanh/bcx-strapi/prod/config.yaml`:

```yaml
S3_BUCKET: "<b2_bucket_name>"
S3_REGION: "<b2_region>"
S3_ENDPOINT: "https://s3.<b2_region>.backblazeb2.com"
S3_ACL: "public-read"
S3_FORCE_PATH_STYLE: "false"
S3_SIGNED_URL_EXPIRES: "900"
```

Set these Secret values as base64 in each environment secret:

```yaml
S3_ACCESS_KEY_ID: "<base64_b2_key_id>"
S3_ACCESS_SECRET: "<base64_b2_application_key>"
```

Example encoding command:

```sh
printf '%s' 'your-b2-application-key' | base64
```
