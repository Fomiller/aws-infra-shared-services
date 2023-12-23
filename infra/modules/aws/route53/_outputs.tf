output "route53_zone_name_fomillercloud_subdomain_public" {
  value = aws_route53_zone.fomillercloud_subdomain_public.name
}

output "route53_zone_id_fomillercloud_subdomain_public" {
  value = aws_route53_zone.fomillercloud_subdomain_public.zone_id
}

output "route53_zone_name_fomillercloud_cluster_subdomain_public" {
  value = aws_route53_zone.fomillercloud_cluster_subdomain_public.name
}

output "route53_zone_id_fomillercloud_cluster_subdomain_public" {
  value = aws_route53_zone.fomillercloud_cluster_subdomain_public.zone_id
}
