resource "aws_waf_xss_match_set" "xss_match_set" {
  name = "${var.name}XssMatchSet"

  xss_match_tuples {
    text_transformation = "NONE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }
}

resource "aws_waf_rule" "xss_match_rule" {
  name        = "${var.name}XssMatchRule"
  metric_name = "${var.name}XssMatchRule"

  predicates {
    data_id = "${aws_waf_xss_match_set.xss_match_set.id}"
    negated = false
    type    = "XssMatch"
  }
}

resource "aws_waf_web_acl" "xss_match_acl" {
  name        = "${var.name}XssMatchAcl"
  metric_name = "${var.name}XssMatchAcl"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = "${aws_waf_rule.xss_match_rule.id}"
  }
}
