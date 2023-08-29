resource "vault_mount" "ecco_sneaks_org_kvv2" {
    path = "ecco-sneaks-org-kvv2"
    type = "kv"
    options = { version = "2" }
    description = "KV version 2 secret engine mount"

}

resource "vault_kv_secret_backend_v2" "ecco_sneaks_org_kvv2_backend" {
    depends_on = [ vault_mount.ecco_sneaks_org_kvv2 ]
    mount = vault_mount.ecco_sneaks_org_kvv2.path
    max_versions = 5
    delete_version_after = 12600
    cas_required = true
}