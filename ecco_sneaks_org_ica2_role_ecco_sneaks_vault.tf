resource "vault_pki_secret_backend_role" "role" {
 backend            = vault_mount.ecco_sneaks_org_v1_ica2_v1.path
 name               = "ecco-sneaks-org-vault"
 ttl                = local.default_1h_in_sec
 allow_ip_sans      = true
 key_type           = "rsa"
 key_bits           = 2048
 key_usage          = [ "DigitalSignature"]
 allow_any_name     = false
 allow_localhost    = false
 allowed_domains    = ["ecco-sneaks-org.com"]
 allow_bare_domains = true
 allow_subdomains   = true
 server_flag        = false
 client_flag        = true
 no_store           = true
 country            = ["US"]
 locality           = ["Dallas"]
 province           = ["TX"]
}