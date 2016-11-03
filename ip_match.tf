resource "aws_waf_ipset" "ipset" {
  name = "${var.name}IpSet"

  ip_set_descriptors {
    type  = "IPV4"
    value = "${var.ipset_config["value"]}"
  }

  ip_set_descriptors {
    type  = "IPV6"
    value = "2620:0:2d0:200::/64"
  }
}

resource "aws_waf_rule" "ip_match_rule" {
  name        = "${var.name}IPMatchRule"
  metric_name = "${var.name}IPMatchRule"

  predicates {
    data_id = "${aws_waf_ipset.ipset.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "ip_match_acl" {
  name        = "${var.name}IPMatchAcl"
  metric_name = "${var.name}IPMatchAcl"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = "${aws_waf_rule.ip_match_rule.id}"
  }
}
