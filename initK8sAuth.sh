#/bin/sh
sleep 10
vault auth enable kubernetes
vault write auth/kubernetes/config token_reviewer_jwt="" kubernetes_host="https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT" kubernetes_ca_cert="-----BEGIN CERTIFICATE-----
MIIC5zCCAc+gAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
cm5ldGVzMB4XDTIxMDIwNjA4MTczOFoXDTMxMDIwNDA4MTczOFowFTETMBEGA1UE
AxMKa3ViZXJuZXRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMAy
iQOxE8wcSiobjirryarLl+bKLhKDWYq0OdAOx8mfw2zpnHEdHd0gud/Fkk0If8jv
j3/6ETMAj4PQOZ7RzM0rv8AeliPkHApzEIUQ7TlNumRHNT3UHD6CtiRvah4qfpai
x4hTpAz8auOPhGmEdxRiVGUAtk7xd4AN6M+tpEbOcQe99vFqIlHJmFFJjpA5jrWU
HpJk8fRY5fiuxArKCI2xenmqpgmbngZLGhg687AYVohJNaAVo/Jtsw1rfgSaaDPY
PXm8qUlIQ0GFpw8XuxioCioQg/zUOu9qA18SKEUpq1UGkqvtAeNbDdZ/VdOuebrh
ggaxlKKbMeGnmBL95f8CAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgKkMA8GA1UdEwEB
/wQFMAMBAf8wHQYDVR0OBBYEFDswA0XWRRTZTN5U9IrVTq44xdw/MA0GCSqGSIb3
DQEBCwUAA4IBAQChAD7iUTFODxc4PBHlvS0U2IZ+pXco96gQ91fy0wf9uuDjKVmC
c3d36zIupmW+tNM1nzj7mIf11clzwv1YTTgSNLezpIFU+jtu11rvKHJT7K1PTDPh
ONwj4IBdJj3dYnEjg25fQNAXEm5/TX7vdae506lF7cvIbdNwWVfjHWrYosVNR0Af
rgim2QInGRQwl41F6Zeh9t6GoBjusTxjdx5rH4pHVAEapQOjgwoeWv4ZrrDAs2F6
MbUW1qFAiKCwDGayY8KMverFXc7IUSbNT5Smsuzs4Qdxsa4HRk0GM3NI4bP0M6lK
zPNLmjktYEBxscxD3Ok4PZEvY5wP8Y+CCKLC
-----END CERTIFICATE-----"
echo "path \"*\"
{
  capabilities = [\"create\", \"read\", \"update\", \"delete\", \"list\", \"sudo\"]
}" | vault policy write acl-all-admin -
vault write auth/kubernetes/role/go-role bound_service_account_names=go-auth bound_service_account_namespaces=default policies=acl-all-admin
