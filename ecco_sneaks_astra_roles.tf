resource "astra_role" "ecco_sneaks_cluster_role" {
    role_name = "eccosneakscluster"
    description ="Role to mimic Ecco Sneaks 'cluster' role"
    effect = "allow"
    resources = [
        "drn:astra:org:33bffe27-a44b-4723-b40d-bdbd6d49b066:db:*",
        "drn:astra:org:33bffe27-a44b-4723-b40d-bdbd6d49b066:db:*:keyspace:*",
        "drn:astra:org:33bffe27-a44b-4723-b40d-bdbd6d49b066:db:*:keyspace:*:table:*"
    ]
    policy = [
    # "org-db-view" is required to list databases
    "org-db-view",
    # the following are for CQl and table operations
    "db-cql", "db-table-alter", "db-table-create", "db-table-describe", "db-table-modify", "db-table-select",
    # the following are for Keysapce operations
    "db-keyspace-alter", "db-keyspace-describe", "db-keyspace-modify", "db-keyspace-authorize", "db-keyspace-drop", "db-keyspace-create", "db-keyspace-grant",
  ]
}

resource "astra_token" "ecco_sneaks_cluster_role_token" {
    roles = [astra_role.ecco_sneaks_cluster_role.id]
}