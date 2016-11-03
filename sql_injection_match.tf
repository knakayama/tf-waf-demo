resource "aws_waf_sql_injection_match_set" "sql_injection_match_set" {
  name = "${var.name}SqlInjectionMatchSet"

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }
}

resource "aws_waf_rule" "sql_injection_match_rule" {
  name        = "${var.name}SqlInjectionMatchRule"
  metric_name = "${var.name}SqlInjectionMatchRule"

  predicates {
    data_id = "${aws_waf_sql_injection_match_set.sql_injection_match_set.id}"
    negated = false
    type    = "SqlInjectionMatch"
  }
}

resource "aws_waf_web_acl" "sql_injection_match_acl" {
  name        = "${var.name}SqlInjectionMatchAcl"
  metric_name = "${var.name}SqlInjectionMatchAcl"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = "${aws_waf_rule.sql_injection_match_rule.id}"
  }
}
