resource "vault_mount" "ecco_sneaks_org_v1_ica1_v1" {
    path = "ecco-sneaks-org/v1/ica1/v1"
    type = "pki"
    description = "PKI enginer hosting intermediate CA1 va for Ecco Sneaks org"
    default_lease_ttl_seconds = local.default_1h_in_sec
    max_lease_ttl_seconds = local.default_3y_in_sec
}

resource "vault_pki_secret_backend_intermediate_cert_request" "ecco_sneaks_org_v1_ica1_v1" {
    depends_on = [ vault_mount.ecco_sneaks_org_v1_ica1_v1 ]
    backend = vault_mount.ecco_sneaks_org_v1_ica1_v1.path
    type = "internal"
    common_name  = "Intermediate CA1 v1 "
    key_type     = "rsa"
    key_bits     = "2048"
    ou           = "DSE"
    organization = "Ecco Sneaks"
    country      = "US"
    locality     = "Dallas"
    province     = "TX"
}

