# Codex Memory: Banchanxanh Kubernetes

This guidance applies only inside `kubernetes/banchanxanh/`.

## Scope

- This folder contains Kubernetes manifests for the Banchanxanh site and CMS.
- Keep changes focused on deployment/runtime configuration, ingress, services, secrets, and Kustomize overlays.
- Do not infer application source-code changes from this folder. App code lives in the container images, not in these manifests.

## Layout

- `ingress.yaml` defines the nginx ingress for production and development Banchanxanh hosts.
- `bcx-hp-host/` deploys the public website frontend.
- `bcx-strapi/` deploys the Strapi CMS backend.
- Each app uses the same Kustomize structure:
  - `base/` has the unsuffixed Deployment, Service, ConfigMap example, Secret example, and base kustomization.
  - `dev/` includes `../base`, `config.yaml`, `secret.yaml`, appends `nameSuffix: -dev`, and rewrites the image to the `develop` Artifact Registry path.
  - `prod/` includes `../base`, `config.yaml`, `secret.yaml`, appends `nameSuffix: -prod`, and rewrites the image to the `prod` Artifact Registry path.

## Naming

- Base resources are unsuffixed, for example `bcx-strapi`, `bcx-strapi-service`, `bcx-strapi-config`, and `bcx-strapi-secret`.
- Rendered dev resources get `-dev`; rendered prod resources get `-prod`.
- Ingress backend services point at rendered service names:
  - `banchanxanh.com` -> `bcx-hp-host-service-prod`
  - `dev.banchanxanh.com` -> `bcx-hp-host-service-dev`
  - `cms.banchanxanh.com` -> `bcx-strapi-service-prod`
  - `dev.cms.banchanxanh.com` -> `bcx-strapi-service-dev`
  - `keycloak.banchanxanh.com` -> `keycloak-service`

## Editing Rules

- Use 2-space YAML indentation and keep key ordering close to neighboring files.
- Keep `envFrom` wired to each app's ConfigMap and Secret unless the user asks for a different environment strategy.
- When adding a runtime environment variable, update the environment-specific `config.yaml` files and the matching `base/config.example.yaml`.
- When adding a secret key, update `base/secret.example.yaml`; avoid committing plaintext secret values.
- Be careful editing `dev/secret.yaml` and `prod/secret.yaml`: values are Kubernetes Secret `data` values and should be base64 encoded.
- Keep `imagePullPolicy: Always` and the existing Artifact Registry image rewrite pattern unless the user asks otherwise.
- Do not change CPU/memory limits, replica counts, TLS settings, hostnames, or image tags casually; these affect live environments.

## Ingress Notes

- `ingress.yaml` is in the `default` namespace and uses `ingressClassName: nginx`.
- TLS is issued with `cert-manager.io/cluster-issuer: letsencrypt-prod`.
- The TLS secret is `banchanxanh-tls-secret`.
- When adding or removing a host, update both `spec.tls[].hosts` and `spec.rules`.
- Preserve the existing nginx annotations unless the user asks for different ingress behavior.

## Strapi Notes

- `bcx-strapi` listens on container port `3000`, while its `PORT` environment variable is currently `1337`.
- Backblaze B2 upload settings are exposed through S3-compatible environment variables in the Strapi ConfigMap and Secret.
- The Strapi app image must include `@strapi/provider-upload-aws-s3` and `config/plugins.ts` provider configuration for B2 uploads; this folder only passes environment variables into the container.

## Validation

- Render overlays before applying changes:

```sh
kubectl kustomize kubernetes/banchanxanh/bcx-hp-host/dev
kubectl kustomize kubernetes/banchanxanh/bcx-hp-host/prod
kubectl kustomize kubernetes/banchanxanh/bcx-strapi/dev
kubectl kustomize kubernetes/banchanxanh/bcx-strapi/prod
```

- For individual manifest checks, prefer:

```sh
kubectl apply --dry-run=client -f kubernetes/banchanxanh/ingress.yaml
```

- Prefer rendering/dry-run checks before suggesting production apply commands.
