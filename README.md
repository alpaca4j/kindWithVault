# kindWithVault
This project sets up kubernetes KIND cluster with HashiCorp Vault intergration.
Just fire install.sh (kind and kubectl binaries need to be in PATH).
Apart from Vault it also installs kubernetes dashboard (you can skip the login screen by pressing skip, duh..)

install.sh :
 - installs Kind cluster
 - deploys K8s dashboard
 - deploys HashiCorp Vault
 - sets up K8s <-> Vault integration
 - creates go-auth k8s serviceaccount to be used to authenticate to vault

forward-ports.sh:
   - forwards ports for kubernetes dashboard and vault

export-secrets.sh:
   - exports go-auth token and ca.crt to /var/run/secrets/kubernetes.io/serviceaccount/ so you can use them to code against the setup
