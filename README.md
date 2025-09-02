# Azure DevOps + AKS + GitOps (ArgoCD) — End-to-End Project

This repo provisions AKS & ACR with Terraform, builds a Docker image, pushes to ACR,
and deploys the app to AKS via **GitOps using ArgoCD**.

## Stack
- Azure: AKS, ACR, Log Analytics
- IaC: Terraform
- CI/CD: Azure DevOps Pipelines (Multi-stage)
- GitOps: ArgoCD
- App: NGINX serving a static page

## Quick Start (Manual once)
1. Create the infra:
   ```bash
   cd terraform
   terraform init
   terraform apply -auto-approve
   ```
2. Get AKS creds:
   ```bash
   az aks get-credentials -g <rg-name> -n <aks-name>
   ```
3. Install ArgoCD:
   ```bash
   kubectl create ns argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   kubectl apply -f manifests/argocd/application.yaml
   ```

## Pipeline Setup
- Create Azure service connection in Azure DevOps: `$(AZURE_SERVICE_CONNECTION)`
- Pipeline variables required:
  - `ACR_NAME`, `ACR_LOGIN_SERVER`, `RG_NAME`, `AKS_NAME`
  - `GITHUB_TOKEN` (if pushing back to GitHub from pipeline)
  - Optional: `BOOTSTRAP_ARGOCD=true` for first run
- Run pipeline (`pipelines/azure-pipelines.yml`).

## Helm values
In `helm/sample-app/values.yaml`, set `image.repository` to your ACR login server and the image name.
