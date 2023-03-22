output "storage_account" {
  value       = length(azurerm_storage_account.storage) > 0 ? azurerm_storage_account.storage[0] : null
  sensitive   = true
  description = "Properties of the Storage Accounts"
}

output "redis_cache" {
  value       = azurerm_redis_cache.redis_cache
  description = "Properties of the Redis Cache"
  sensitive   = true
}

output "private_endpoint" {
  value       = azurerm_private_endpoint.private_endpoint
  description = "Properties of the Private Endpoint"
}
