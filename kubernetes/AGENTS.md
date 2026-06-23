# Codex Memory: Kubernetes

This guidance applies only inside the `kubernetes/` directory.

## Scope

- This directory contains raw Kubernetes manifests for ingress, cert-manager, and Keycloak resources.
- Keep changes focused on Kubernetes YAML. Do not infer application code changes from this folder.
- Preserve the existing simple manifest style unless the user explicitly asks for Kustomize, Helm, or a larger restructure.

## Current Layout

- `issuer.yaml` defines the `letsencrypt-prod` cert-manager `ClusterIssuer`.
- `banchanxanh/ingress.yaml` defines nginx ingress rules for `banchanxanh.com`, CMS, dev hosts, and Keycloak.
- `kachigo.jp/ingress.yaml` defines nginx ingress for `n8n.kachigo.jp`.
- `keycloak/` contains namespace, config, service, load balancer, storage, and deployment manifests for Keycloak.

## Editing Rules

- Use 2-space YAML indentation and keep key ordering close to the surrounding files.
- Avoid committing plaintext secrets. If a manifest references secrets, keep them as `Secret` references or placeholders unless the user provides a safe secret-management plan.
- Be careful with namespaces:
  - ingress manifests currently use `namespace: default`;
  - Keycloak manifests use `namespace: keycloak`.
- Be careful with TLS secret names and host lists. When adding or removing an ingress host, update both `spec.tls[].hosts` and `spec.rules`.
- Keep nginx ingress annotations consistent unless the user asks for different behavior.
- Do not change the cert-manager issuer email, ACME server, or issuer name casually; these are cluster-facing settings.

## Operational Context

- The repository README includes useful commands for GKE credentials, rollout restarts, Kustomize output, and config/secret inspection.
- The likely GKE cluster is `bcx-cluster` in region `us-central1`, project `banchanxanh`.
- Prefer dry-run or render checks before suggesting apply commands for production-facing resources.

## Validation

- For syntax checks, prefer:

```sh
kubectl apply --dry-run=client -f <file>
```

- For directory-level checks, use:

```sh
kubectl apply --dry-run=client -f kubernetes/
```

- If `kubectl` or cluster credentials are unavailable locally, state that clearly and still validate the YAML structure by inspection.
