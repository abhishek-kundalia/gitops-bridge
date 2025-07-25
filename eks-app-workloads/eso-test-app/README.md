# External Secrets Operator Test Application

This application tests the integration between External Secrets Operator (ESO) and AWS Secrets Manager using IRSA (IAM Roles for Service Accounts).

## Overview

The test validates:
- IRSA authentication with AWS Secrets Manager
- Secret synchronization from AWS to Kubernetes
- Application consumption of synced secrets

## Architecture

```
AWS Secrets Manager (qa/demo/eso)
    ↓ (IRSA Authentication)
External Secrets Operator
    ↓ (SecretStore + ExternalSecret)
Kubernetes Secret (eso-demo-secret)
    ↓ (Volume Mount)
Test Application Pod
```

## Components

### Infrastructure (ESO Resources)
- **ServiceAccount**: `eso-demo-sa` with IRSA annotation
- **SecretStore**: `aws-secrets-manager` connecting to AWS Secrets Manager
- **ExternalSecret**: `eso-demo-secret` syncing from `qa/demo/eso`

### Test Application
- **Deployment**: Simple busybox container that validates secret availability
- **Service**: ClusterIP service for the test app
- **Namespace**: `eso-test-app`

## Deployment

The application is automatically deployed by ArgoCD's folder-based ApplicationSet when this directory is committed to the repository.

## Validation Commands

### Check ESO Resources Status
```bash
# Check SecretStore status
kubectl get secretstore aws-secrets-manager -n external-secrets -o yaml

# Check ExternalSecret status
kubectl get externalsecret eso-demo-secret -n external-secrets -o yaml

# Check if Kubernetes secret was created
kubectl get secret eso-demo-secret -n eso-test-app
```

### Check Test Application
```bash
# Check pod status
kubectl get pods -n eso-test-app

# View application logs
kubectl logs -n eso-test-app deployment/eso-test-app -f

# Describe the secret (without exposing values)
kubectl describe secret eso-demo-secret -n eso-test-app
```

### Troubleshooting Commands
```bash
# Check service account
kubectl describe sa eso-demo-sa -n external-secrets

# Check SecretStore events
kubectl describe secretstore aws-secrets-manager -n external-secrets

# Check ExternalSecret events
kubectl describe externalsecret eso-demo-secret -n external-secrets

# Check ESO controller logs
kubectl logs -n external-secrets deployment/external-secrets -f
```

## Expected Behavior

1. **SecretStore** should show `Ready: True` status
2. **ExternalSecret** should show `Ready: True` and `Synced: True` status
3. **Kubernetes Secret** should be created in `eso-test-app` namespace
4. **Test Pod** should start successfully and log:
   - "Secret found! Validating secret data..."
   - List of secret files and their sizes
   - "✅ External Secrets integration working successfully!"

## Configuration

### AWS Secret
- **Name**: `qa/demo/eso`
- **Region**: `us-east-1`
- **Type**: Key-value pairs

### IAM Role
- **ARN**: `arn:aws:iam::856517911253:role/eso-demo-iam-role`
- **Policy**: Must have `secretsmanager:GetSecretValue` permission for `qa/demo/eso`

### Refresh Interval
- **Current**: 15 seconds (for testing)
- **Production**: Consider increasing to 5-15 minutes

## Security Notes

- The test application validates secret presence without exposing secret values in logs
- Secrets are mounted as read-only volumes
- IRSA provides secure, temporary credentials without storing AWS keys
