output "app_public_ip" {
  value = "${module.main.app_public_ip}"
}

output "cf_domain_name" {
  value = "${module.main.cf_domain_name}"
}

output "cf_id" {
  value = "${module.main.cf_id}"
}

output "elb_dns_name" {
  value = "${module.main.elb_dns_name}"
}

output "ip_match_web_acl_id" {
  value = "${module.main.ip_match_web_acl_id}"
}

output "byte_match_web_acl_id" {
  value = "${module.main.byte_match_web_acl_id}"
}

output "size_constraint_web_acl_id" {
  value = "${module.main.size_constraint_web_acl_id}"
}

output "sql_injection_match_web_acl_id" {
  value = "${module.main.sql_injection_match_web_acl_id}"
}

output "xss_match_web_acl_id" {
  value = "${module.main.xss_match_web_acl_id}"
}
