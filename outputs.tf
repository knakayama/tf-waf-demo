output "app_public_ip" {
  value = "${aws_instance.app.public_ip}"
}

output "cf_domain_name" {
  value = "${aws_cloudfront_distribution.cf.domain_name}"
}

output "cf_id" {
  value = "${aws_cloudfront_distribution.cf.id}"
}

output "elb_dns_name" {
  value = "${aws_elb.elb.dns_name}"
}

output "ip_match_web_acl_id" {
  value = "${aws_waf_web_acl.ip_match_acl.id}"
}

output "byte_match_web_acl_id" {
  value = "${aws_waf_web_acl.byte_match_acl.id}"
}

output "size_constraint_web_acl_id" {
  value = "${aws_waf_web_acl.size_constraint_acl.id}"
}

output "sql_injection_match_web_acl_id" {
  value = "${aws_waf_web_acl.sql_injection_match_acl.id}"
}

output "xss_match_web_acl_id" {
  value = "${aws_waf_web_acl.xss_match_acl.id}"
}
