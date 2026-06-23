# Flowise on Kubernetes

This deploys the open-source Flowise image behind the shared `kachigo.jp` ingress at:

```text
https://flowise.kachigo.jp
```

Before applying the Kustomize directory, create a real secret file from the example:

```sh
cp kubernetes/kachigo.jp/flowise/secret.example.yaml kubernetes/kachigo.jp/flowise/secret.yaml
```

Replace every placeholder in `secret.yaml` with strong values. For the `*-SECRET` values, a good default is:

```sh
openssl rand -hex 32
```

Then deploy Flowise and update ingress:

```sh
kubectl apply -k kubernetes/kachigo.jp/flowise
kubectl apply -f kubernetes/kachigo.jp/ingress.yaml
```

The manifests expect Postgres to be reachable at `cloudsql-proxy:5432` and use:

```text
DATABASE_NAME=flowise
DATABASE_USER=flowise-user
```

Create that database/user in Postgres or update `config.yaml` to match your existing Cloud SQL setup.

File/blob storage is configured for Backblaze B2 through its S3-compatible API:

```text
STORAGE_TYPE=s3
S3_STORAGE_BUCKET_NAME=replace-with-b2-bucket-name
S3_STORAGE_REGION=replace-with-b2-region
S3_ENDPOINT_URL=https://s3.replace-with-b2-region.backblazeb2.com
S3_FORCE_PATH_STYLE=true
```

Update those values in `config.yaml`, then set the B2 credentials in `secret.yaml`:

```text
S3_STORAGE_ACCESS_KEY_ID=replace-with-b2-key-id
S3_STORAGE_SECRET_ACCESS_KEY=replace-with-b2-application-key
```

Logs are not written to a mounted volume. Flowise writes to the container output, so inspect logs with:

```sh
kubectl logs deploy/flowise -n default
```

On GKE, those stdout/stderr logs are collected by Cloud Logging when cluster logging is enabled. No persistent volume is required for this setup.
