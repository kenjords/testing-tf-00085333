terraform {
    required_providers {
      vault = {
        source = "hashicorp/vault"
        version = "3.19.0"
      }
      astra = {
        source = "datastax/astra"
        version = "2.2.0"
      }
    }
}

provider astra {
    
}

provider vault {
}

locals {
    default_3y_in_sec = 94608000
    default_1y_in_sec = 31536000
    default_1h_in_sec = 3600
}