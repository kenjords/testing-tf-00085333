resource "astra_database" "ecco_sneaks_cluster_db" {
    name = "eccosneakscluster"
    keyspace = "crystal"
    cloud_provider = "aws"
    regions = ["us-east-1"]
}

resource "astra_keyspace" "ecco_sneaks_ks_omni_channel" {
    database_id = astra_database.ecco_sneaks_cluster_db.id
    name = "omni_channel"
}

resource "astra_keyspace" "ecco_sneaks_ks_sct" {
  database_id = astra_database.ecco_sneaks_cluster_db.id
  name = "sct"
}

resource "astra_keyspace" "ecco_sneaks_ks_wagyu" {
    database_id = astra_database.ecco_sneaks_cluster_db.id
    name = "wagyu"
}

resource "astra_keyspace" "ecco_sneaks_ks_beast" {
    database_id = astra_database.ecco_sneaks_cluster_db.id
    name = "beast"
}

resource "astra_table" "ecco_sneaks_cluster_db_table_crystal_info" {
    keyspace = astra_database.ecco_sneaks_cluster_db.keyspace
    database_id = astra_database.ecco_sneaks_cluster_db.id
    region = astra_database.ecco_sneaks_cluster_db.regions[0]
    table = "crystal_info"
    clustering_columns = "crystal_clear"
    partition_keys = "crystal_id:crystal_location"
    column_definitions = [
        {
            Name : "crystal_id"
            Static : false
            TypeDefinition : "uuid"
        },
        {
            Name : "crystal_location"
            Static : false
            TypeDefinition : "text"
        },
        {
            Name : "crystal_clear"
            Static : false
            TypeDefinition : "text"
        }
    ]
}