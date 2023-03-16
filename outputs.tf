output "storage_account" {
  value       = azurerm_storage_account.storage
  sensitive   = true
  description = "Properties of the Storage Accounts"
}

output "redis_cache" {
  value       = azurerm_redis_cache.redis_cache
  description = "Properties of the Redis Cache"
  sensitive   = true
}
