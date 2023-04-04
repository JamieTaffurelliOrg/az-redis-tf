# az-redis-tf
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.20 |
| <a name="provider_azurerm.dns"></a> [azurerm.dns](#provider\_azurerm.dns) | ~> 3.20 |
| <a name="provider_azurerm.logs"></a> [azurerm.logs](#provider\_azurerm.logs) | ~> 3.20 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.redis_cache_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.storage_account_blob_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.storage_account_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_redis_cache.redis_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_redis_firewall_rule.redis_firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_firewall_rule) | resource |
| [azurerm_resource_group_template_deployment.private_dns_zone_group_template](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) | resource |
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules.rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |
| [azurerm_log_analytics_workspace.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_private_dns_zone.private_dns_zones](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aof_backup_enabled"></a> [aof\_backup\_enabled](#input\_aof\_backup\_enabled) | Enable AOF persistence | `bool` | `false` | no |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4, 5 | `number` | n/a | yes |
| <a name="input_day_of_week"></a> [day\_of\_week](#input\_day\_of\_week) | Day of week to patch | `string` | n/a | yes |
| <a name="input_family"></a> [family](#input\_family) | The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium) | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location to deploy resources | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Name of Log Analytics Workspace to send diagnostics | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | Resource Group of Log Analytics Workspace to send diagnostics | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Patching window length | `string` | `"PT5H"` | no |
| <a name="input_maxfragmentationmemory_reserved"></a> [maxfragmentationmemory\_reserved](#input\_maxfragmentationmemory\_reserved) | Value in megabytes reserved to accommodate for memory fragmentation. | `number` | `null` | no |
| <a name="input_maxmemory_delta"></a> [maxmemory\_delta](#input\_maxmemory\_delta) | The max-memory delta for this Redis instance. | `number` | `null` | no |
| <a name="input_maxmemory_policy"></a> [maxmemory\_policy](#input\_maxmemory\_policy) | How Redis will select what to remove when maxmemory is reached. | `string` | `"volatile-lru"` | no |
| <a name="input_maxmemory_reserved"></a> [maxmemory\_reserved](#input\_maxmemory\_reserved) | Value in megabytes reserved for non-cache usage e.g. failover. | `number` | `null` | no |
| <a name="input_notify_keyspace_events"></a> [notify\_keyspace\_events](#input\_notify\_keyspace\_events) | Enable keysapce notifications | `string` | `null` | no |
| <a name="input_private_dns_zones"></a> [private\_dns\_zones](#input\_private\_dns\_zones) | Private DNS zones to link to Redis Private Endpoint | <pre>list(object({<br>    name                = string<br>    resource_group_name = string<br>  }))</pre> | n/a | yes |
| <a name="input_private_static_ip_address"></a> [private\_static\_ip\_address](#input\_private\_static\_ip\_address) | The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. This argument implies the use of subnet\_id. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this Redis Cache | `bool` | `false` | no |
| <a name="input_rdb_backup_enabled"></a> [rdb\_backup\_enabled](#input\_rdb\_backup\_enabled) | Enable Redis backups | `bool` | `false` | no |
| <a name="input_redis_cache_name"></a> [redis\_cache\_name](#input\_redis\_cache\_name) | Name of Redis Cache to deploy | `string` | n/a | yes |
| <a name="input_redis_firewall_rules"></a> [redis\_firewall\_rules](#input\_redis\_firewall\_rules) | The Redis Cache firewall rules | <pre>list(object(<br>    {<br>      name     = string<br>      start_ip = string<br>      end_ip   = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | Version of Redis | `number` | `6` | no |
| <a name="input_replicas_per_master"></a> [replicas\_per\_master](#input\_replicas\_per\_master) | Amount of replicas to create per master for this Redis Cache. | `number` | `null` | no |
| <a name="input_replicas_per_primary"></a> [replicas\_per\_primary](#input\_replicas\_per\_primary) | Amount of replicas to create per primary for this Redis Cache. If both replicas\_per\_primary and replicas\_per\_master are set, they need to be equal. | `number` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Resource Group to deploy to | `string` | n/a | yes |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | The number of Shards to create on the Redis Cluster | `number` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of Redis to use. Possible values are Basic, Standard and Premium | `string` | n/a | yes |
| <a name="input_start_hour_utc"></a> [start\_hour\_utc](#input\_start\_hour\_utc) | Start hour of patch | `number` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the storage account to store Redis backups | `string` | `null` | no |
| <a name="input_storage_account_network_rules"></a> [storage\_account\_network\_rules](#input\_storage\_account\_network\_rules) | The Storage Account firewall rules | <pre>object(<br>    {<br>      default_action             = optional(string, "Deny")<br>      ip_rules                   = optional(list(string), [])<br>      virtual_network_subnet_ids = optional(list(string), [])<br>    }<br>  )</pre> | `{}` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet within which the Redis Cache should be deployed. | `string` | `null` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the resource group of the subnet to deploy private endpoint | `string` | n/a | yes |
| <a name="input_subnet_resource_group_name"></a> [subnet\_resource\_group\_name](#input\_subnet\_resource\_group\_name) | The name of the resource group of the subnet to deploy private endpoint | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The name of the resource group of the subnet to deploy private endpoint | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | Availability zone to deploy Redis nodes to | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_endpoint"></a> [private\_endpoint](#output\_private\_endpoint) | Properties of the Private Endpoint |
| <a name="output_redis_cache"></a> [redis\_cache](#output\_redis\_cache) | Properties of the Redis Cache |
| <a name="output_storage_account"></a> [storage\_account](#output\_storage\_account) | Properties of the Storage Accounts |
<!-- END_TF_DOCS -->
