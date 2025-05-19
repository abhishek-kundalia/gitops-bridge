# Folder-Based Application Pattern

This directory contains a pattern for automatically creating applications based on the folder structure. Each subdirectory with a `kustomization.yaml` file will be deployed as a separate application in its own namespace.

## How It Works

The `folder-based-appset.yaml` file contains an ApplicationSet that:

1. Scans the repository for directories matching the pattern `eks-app-workloads/*/kustomization.yaml`
2. For each matching directory, creates an Argo CD Application
3. Each Application is named after the directory (e.g., `sample-app`)
4. Each Application is deployed to a namespace with the same name as the directory (e.g., `sample-app` namespace)

## Adding a New Application

To add a new application:

1. Create a new directory under `eks-app-workloads/` (e.g., `eks-app-workloads/my-new-app/`)
2. Add your Kubernetes manifests to the directory
3. Create a `kustomization.yaml` file that references your manifests
4. Commit and push your changes

The ApplicationSet will automatically detect the new directory and create a new Application for it.

## Example

The repository includes two example applications:

- `sample-app`: A simple Nginx deployment
- `another-app`: Another simple Nginx deployment

Each application is deployed to its own namespace.
