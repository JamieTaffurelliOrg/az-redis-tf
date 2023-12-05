resource "azurerm_storage_account" "storage" {
  #checkov:skip=CKV2_AZURE_33:This is an old way of logging, diagnostics are enabled
  #checkov:skip=CKV_AZURE_33:This is an old way of logging, diagnostics are enabled
  #checkov:skip=CKV2_AZURE_18:This is unnecessary for most scenarios
  #checkov:skip=CKV2_AZURE_1:We may require some storage accounts to not have firewalls
  #checkov:skip=CKV_AZURE_59:Value is deprecated
  count                           = var.storage_account_name != null ? 1 : 0
  name                            = var.storage_account_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  access_tier                     = "Hot"
  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true

  blob_properties {
    versioning_enabled            = true
    change_feed_enabled           = true
    change_feed_retention_in_days = 365
    last_access_time_enabled      = true

    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }
  }

  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

resource "azurerm_storage_account_network_rules" "rules" {
  #checkov:skip=CKV_AZURE_35:We may require these storage accounts to be publicly accessible
  count                      = var.storage_account_name != null ? 1 : 0
  storage_account_id         = azurerm_storage_account.storage[0].id
  default_action             = var.storage_account_network_rules.default_action
  ip_rules                   = var.storage_account_network_rules.ip_rules
  virtual_network_subnet_ids = var.storage_account_network_rules.virtual_network_subnet_ids
  bypass                     = ["Logging", "Metrics", "AzureServices"]
}

resource "azurerm_monitor_diagnostic_setting" "storage_account_diagnostics" {
  count                      = var.storage_account_name != null ? 1 : 0
  name                       = "${var.log_analytics_workspace_name}-security-logging"
  target_resource_id         = azurerm_storage_account.storage[0].id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logs.id

  metric {
    category = "Transaction"

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  metric {
    category = "Capacity"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_account_blob_diagnostics" {
  for_each                   = var.storage_account_name != null ? toset(["blobServices", "fileServices", "tableServices", "queueServices"]) : toset([])
  name                       = "${var.log_analytics_workspace_name}-security-logging"
  target_resource_id         = "${azurerm_storage_account.storage[0].id}/${each.key}/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logs.id

  log {
    category = "StorageRead"

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  log {
    category = "StorageWrite"

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  log {
    category = "StorageDelete"

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  metric {
    category = "Transaction"

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  metric {
    category = "Capacity"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }

  depends_on = [
    azurerm_storage_account.storage
  ]
}

resource "azurerm_redis_cache" "redis_cache" {
  name                          = var.redis_cache_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  capacity                      = var.capacity
  family                        = var.family
  sku_name                      = var.sku_name
  enable_non_ssl_port           = false
  minimum_tls_version           = "1.2"
  private_static_ip_address     = var.private_static_ip_address
  public_network_access_enabled = var.public_network_access_enabled
  replicas_per_master           = var.replicas_per_master
  replicas_per_primary          = var.replicas_per_primary
  redis_version                 = var.redis_version
  shard_count                   = var.shard_count
  subnet_id                     = var.subnet_id
  zones                         = var.zones


  identity {
    type = "SystemAssigned"
  }

  redis_configuration {
    aof_backup_enabled              = var.aof_backup_enabled
    aof_storage_connection_string_0 = var.aof_backup_enabled == true && var.storage_account_name != null ? "DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.storage[0].primary_blob_endpoint};AccountName=${azurerm_storage_account.storage[0].name};AccountKey=${azurerm_storage_account.storage[0].primary_access_key}" : null
    aof_storage_connection_string_1 = var.aof_backup_enabled == true && var.storage_account_name != null ? "DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.storage[0].primary_blob_endpoint};AccountName=${azurerm_storage_account.storage[0].name};AccountKey=${azurerm_storage_account.storage[0].secondary_access_key}" : null
    enable_authentication           = true
    maxmemory_reserved              = var.maxmemory_reserved
    maxmemory_delta                 = var.maxmemory_delta
    maxmemory_policy                = var.maxmemory_policy
    maxfragmentationmemory_reserved = var.maxfragmentationmemory_reserved
    rdb_backup_enabled              = var.rdb_backup_enabled
    rdb_backup_frequency            = var.rdb_backup_enabled == true ? 15 : null
    rdb_backup_max_snapshot_count   = var.rdb_backup_enabled == true ? 1 : null
    rdb_storage_connection_string   = var.rdb_backup_enabled == true && var.storage_account_name != null ? "DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.storage[0].primary_blob_endpoint};AccountName=${azurerm_storage_account.storage[0].name};AccountKey=${azurerm_storage_account.storage[0].primary_access_key}" : null
    notify_keyspace_events          = var.notify_keyspace_events
  }

  patch_schedule {
    day_of_week        = var.day_of_week
    start_hour_utc     = var.start_hour_utc
    maintenance_window = var.maintenance_window
  }

  lifecycle {
    ignore_changes = [
      redis_configuration[0].rdb_storage_connection_string
    ]
  }
  tags = var.tags
}

resource "azurerm_redis_firewall_rule" "redis_firewall" {
  for_each            = { for k in var.redis_firewall_rules : k.name => k if k != null }
  name                = each.key
  redis_cache_name    = azurerm_redis_cache.redis_cache.name
  resource_group_name = var.resource_group_name
  start_ip            = each.value["start_ip"]
  end_ip              = each.value["end_ip"]
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "${azurerm_redis_cache.redis_cache.name}-pep-1"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = data.azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "${azurerm_redis_cache.redis_cache.name}-psc-1"
    private_connection_resource_id = azurerm_redis_cache.redis_cache.id
    is_manual_connection           = false
    subresource_names              = ["redisCache"]
  }
}

resource "azurerm_resource_group_template_deployment" "private_dns_zone_group_template" {
  name                = "${azurerm_redis_cache.redis_cache.name}-customdns"
  resource_group_name = var.resource_group_name
  template_content    = file("arm/privateDnsZoneGroup.json")
  parameters_content = jsonencode({
    "privateDnsZoneGroupName" = {
      value = "customdns"
    },
    "privateEndpointName" = {
      value = azurerm_private_endpoint.private_endpoint.name
    },
    "privateDnsZoneResourceIds" = {
      value = [for private_dns_zone in data.azurerm_private_dns_zone.private_dns_zones : private_dns_zone.id]
    }
  })
  deployment_mode = "Incremental"
}

resource "azurerm_monitor_diagnostic_setting" "redis_cache_diagnostics" {
  name                       = "${var.log_analytics_workspace_name}-security-logging"
  target_resource_id         = azurerm_redis_cache.redis_cache.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logs.id

  log {
    category = "ConnectedClientList"

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }
}
