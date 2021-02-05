#/bin/bash

kind create cluster --name kind
kubectl cluster-info --context kind-kind
kubectl apply -f k8s_dashboard.yaml
kubectl apply -f vault-namespace.yaml
kubectl apply -f vault-auth-sa.yaml
TOKEN_REVIEW_JWT=$(kubectl get secret vault-auth --output="go-template={{ .data.token }}" | base64 --decode)
KUBE_CA_CERT=$(kubectl config view --raw --minify --flatten --output="jsonpath={.clusters[].cluster.certificate-authority-data}" | base64 --decode)
#sed -e "s/\${TOKEN_REVIEW_JWT}/$TOKEN_REVIEW_JWT/" -e "s/\${KUBE_CA_CERT}/$KUBE_CA_CERT/" < configMapInitK8s.template > configMapInitK8s.yaml
awk -v TOKEN_REVIEW_JWT="$TOKEN_REVIEW_JWT" -v KUBE_CA_CERT="$KUBE_CA_CERT" '{
sub(/\${TOKEN_REVIEW_JWT}/,TOKEN_REVIEW_JWT);
sub(/\${KUBE_CA_CERT}/,KUBE_CA_CERT);
print;
}' initK8sAuth.template > initK8sAuth.sh

kubectl create configmap init --from-file=initK8sAuth.sh --namespace vault

kubectl apply -f install_vault_k8s.yaml 
kubectl apply -f go-service-account.yaml
