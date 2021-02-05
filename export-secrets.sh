sudo mkdir -p /var/run/secrets/kubernetes.io/serviceaccount

TOKEN_K8S_GO=$(kubectl get secret go-auth --output="go-template={{ .data.token }}" | base64 --decode)
kubectl get secret go-auth -o jsonpath='{.data.ca\.crt}' | base64 -d > /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
echo $TOKEN_K8S_GO > /var/run/secrets/kubernetes.io/serviceaccount/token
