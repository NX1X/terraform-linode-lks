# Add the ArgoCD Helm repository
helm repo add argo https://argoproj.github.io/argo-helm

# Update your helm repo
helm repo update

# Create a namespace for ArgoCD
kubectl create namespace argocd

# Install ArgoCD
helm install argocd argo/argo-cd --namespace argocd

# Wait for the pods to be ready
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s