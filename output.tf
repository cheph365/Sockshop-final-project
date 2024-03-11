output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}

output "aks_cluster_location" {
  value = azurerm_kubernetes_cluster.k8s.location
}

output "aks_cluster_resource_group" {
  value = azurerm_kubernetes_cluster.k8s.resource_group_name
}

output "aks_cluster_dns_prefix" {
  value = azurerm_kubernetes_cluster.k8s.dns_prefix
}