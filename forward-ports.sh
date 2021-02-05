#/bin/bash
nohup kubectl port-forward service/kubernetes-dashboard 8443:443 --namespace kubernetes-dashboard &
nohup kubectl port-forward service/vault 8200:8200 --namespace vault &
