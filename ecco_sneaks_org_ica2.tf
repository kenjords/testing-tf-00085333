resource "vault_mount" "ecco_sneaks_org_v1_ica2_v1" {
 path                      = "ecco-sneaks-org/v1/ica2/v1"
 type                      = "pki"
 description               = "PKI engine hosting intermediate CA2 v1 for test org"
 default_lease_ttl_seconds = local.default_1h_in_sec
 max_lease_ttl_seconds     = local.default_1y_in_sec
}

resource "vault_pki_secret_backend_intermediate_cert_request" "ecco_sneaks_org_v1_ica2_v1" {
 depends_on   = [vault_mount.ecco_sneaks_org_v1_ica2_v1]
 backend      = vault_mount.ecco_sneaks_org_v1_ica2_v1.path
 type         = "internal"
 common_name  = "Intermediate CA2 v1 "
 key_type     = "rsa"
 key_bits     = "2048"
 ou           = "test org"
 organization = "test"
 country      = "US"
 locality     = "Bethesda"
 province     = "MD"
}

resource "vault_pki_secret_backend_root_sign_intermediate" "ecco_sneaks_org_v1_sign_ica2_v1_by_ica1_v1" {
 depends_on = [
   vault_mount.ecco_sneaks_org_v1_ica1_v1,
   vault_pki_secret_backend_intermediate_cert_request.ecco_sneaks_org_v1_ica2_v1,
 ]
 backend              = vault_mount.ecco_sneaks_org_v1_ica1_v1.path
 csr                  = vault_pki_secret_backend_intermediate_cert_request.ecco_sneaks_org_v1_ica2_v1.csr
 common_name          = "Intermediate CA2 v1.1"
 exclude_cn_from_sans = true
 ou                   = "00085331"
 organization         = "Ecco Sneaks"
 country              = "US"
 locality             = "Dallas"
 province             = "TX"
 max_path_length      = 1
 ttl                  = local.default_1y_in_sec
}

resource "vault_pki_secret_backend_intermediate_set_signed" "ecco_sneaks_org_v1_ica2_v1_signed_cert" {
 depends_on  = [vault_pki_secret_backend_root_sign_intermediate.ecco_sneaks_org_v1_sign_ica2_v1_by_ica1_v1]
 backend     = vault_mount.ecco_sneaks_org_v1_ica2_v1.path
 certificate = format("%s\n%s", vault_pki_secret_backend_root_sign_intermediate.ecco_sneaks_org_v1_sign_ica2_v1_by_ica1_v1.certificate, file("./cacerts/ecco_sneaks_org_v1_ica1_v1.crt"))
}
