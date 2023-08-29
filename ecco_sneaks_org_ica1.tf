resource "vault_pki_secret_backend_intermediate_set_signed" "ecco_sneaks_org_v1_ica1_v1_signed_cert" {
 depends_on   = [vault_mount.ecco_sneaks_org_v1_ica1_v1]
 backend      = vault_mount.ecco_sneaks_org_v1_ica1_v1.path

 certificate = file("./cacerts/ecco_sneaks_org_v1_ica1_v1.crt")
}