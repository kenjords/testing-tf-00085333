# Generate a random pet name to avoid naming conflicts
resource "random_pet" "pet_name" {}

resource "astra_streaming_tenant" "ecco_sneaks_streaming_tenant" {
  tenant_name = substr("ecco-sneaks-tenant-${random_pet.pet_name.id}", 0, 32)
  user_email = "kenneth@yaay.us"
  cloud_provider = "aws"
  deletion_protection = false
  region = "us-east-1"
}

resource "astra_streaming_namespace" "ecco_sneaks_streaming_namespace" {
    cluster = astra_streaming_tenant.ecco_sneaks_streaming_tenant.cluster_name
    tenant = astra_streaming_tenant.ecco_sneaks_streaming_tenant.tenant_name
    namespace = "crystalns"
}

resource "astra_streaming_topic" "ecco_sneaks_streaming_topic" {
    cluster = astra_streaming_tenant.ecco_sneaks_streaming_tenant.cluster_name
    tenant = astra_streaming_tenant.ecco_sneaks_streaming_tenant.tenant_name
    namespace = astra_streaming_namespace.ecco_sneaks_streaming_namespace.namespace
    topic = "ecco_sneaks_sreaming_topic"
    deletion_protection = false
    num_partitions = 2
    partitioned = true
    persistent = true
}

resource "astra_cdc" "ecco_sneaks_streaming_cdc" {
   database_id = astra_database.ecco_sneaks_cluster_db.id
   database_name = astra_database.ecco_sneaks_cluster_db.name
   table = astra_table.ecco_sneaks_cluster_db_table_crystal_info.table
   keyspace = astra_database.ecco_sneaks_cluster_db.keyspace
   tenant_name = astra_streaming_tenant.ecco_sneaks_streaming_tenant.tenant_name
   topic_partitions = 2
}