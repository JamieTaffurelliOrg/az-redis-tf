variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group to deploy to"
}

variable "location" {
  type        = string
  description = "Location to deploy resources"
}

variable "redis_cache_name" {
  type        = string
  description = "Name of Redis Cache to deploy"
}

variable "capacity" {
  type        = number
  description = "The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4, 5"
}

variable "family" {
  type        = string
  description = "The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium)"
}

variable "sku_name" {
  type        = string
  description = "The SKU of Redis to use. Possible values are Basic, Standard and Premium"
}

variable "private_static_ip_address" {
  type        = string
  default     = null
  description = "The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. This argument implies the use of subnet_id."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Whether or not public network access is allowed for this Redis Cache"
}

variable "replicas_per_master" {
  type        = number
  default     = null
  description = "Amount of replicas to create per master for this Redis Cache."
}

variable "replicas_per_primary" {
  type        = number
  default     = null
  description = "Amount of replicas to create per primary for this Redis Cache. If both replicas_per_primary and replicas_per_master are set, they need to be equal."
}

variable "redis_version" {
  type        = number
  default     = 6
  description = "Version of Redis"
}

variable "shard_count" {
  type        = number
  default     = null
  description = "The number of Shards to create on the Redis Cluster"
}

variable "subnet_id" {
  type        = string
  default     = null
  description = "The ID of the Subnet within which the Redis Cache should be deployed."
}

variable "zones" {
  type        = list(string)
  default     = null
  description = "Availability zone to deploy Redis nodes to"
}

variable "aof_backup_enabled" {
  type        = bool
  default     = false
  description = "Enable AOF persistence"
}

variable "maxmemory_reserved" {
  type        = number
  default     = null
  description = "Value in megabytes reserved for non-cache usage e.g. failover."
}

variable "maxmemory_delta" {
  type        = number
  default     = null
  description = "The max-memory delta for this Redis instance."
}

variable "maxmemory_policy" {
  type        = string
  default     = "volatile-lru"
  description = "How Redis will select what to remove when maxmemory is reached."
}

variable "maxfragmentationmemory_reserved" {
  type        = number
  default     = null
  description = "Value in megabytes reserved to accommodate for memory fragmentation."
}

variable "rdb_backup_enabled" {
  type        = bool
  default     = false
  description = "Enable Redis backups"
}

variable "notify_keyspace_events" {
  type        = string
  default     = null
  description = "Enable keysapce notifications"
}

variable "day_of_week" {
  type        = string
  description = "Day of week to patch"
}

variable "start_hour_utc" {
  type        = number
  description = "Start hour of patch"
}

variable "maintenance_window" {
  type        = string
  default     = "PT5H"
  description = "Patching window length"
}

variable "redis_firewall_rules" {
  type = list(object(
    {
      name     = string
      start_ip = string
      end_ip   = string
    }
  ))
  default     = []
  description = "The Redis Cache firewall rules"
}

variable "storage_account_name" {
  type        = string
  default     = null
  description = "The name of the storage account to store Redis backups"
}

variable "storage_account_network_rules" {
  type = object(
    {
      default_action             = optional(string, "Deny")
      ip_rules                   = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string), [])
    }
  )
  default     = {}
  description = "The Storage Account firewall rules"
}

variable "subnet_name" {
  type        = string
  description = "The name of the resource group of the subnet to deploy private endpoint"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the resource group of the subnet to deploy private endpoint"
}

variable "subnet_resource_group_name" {
  type        = string
  description = "The name of the resource group of the subnet to deploy private endpoint"
}

variable "private_dns_zones" {
  type = list(object({
    name                = string
    resource_group_name = string
  }))
  description = "Private DNS zones to link to Redis Private Endpoint"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Name of Log Analytics Workspace to send diagnostics"
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "Resource Group of Log Analytics Workspace to send diagnostics"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}
