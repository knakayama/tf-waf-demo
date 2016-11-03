resource "aws_waf_byte_match_set" "byte_set" {
  name = "${var.name}ByteSet"

  byte_match_tuples {
    text_transformation   = "LOWERCASE"
    target_string         = "test-string"
    positional_constraint = "CONTAINS"

    field_to_match {
      type = "HEADER"
      data = "user-agent"
    }
  }
}

resource "aws_waf_rule" "byte_match_rule" {
  name        = "${var.name}ByteMatchRule"
  metric_name = "${var.name}ByteMatchRule"

  predicates {
    data_id = "${aws_waf_byte_match_set.byte_set.id}"
    negated = false
    type    = "ByteMatch"
  }
}

resource "aws_waf_web_acl" "byte_match_acl" {
  name        = "${var.name}ByteMatchAcl"
  metric_name = "${var.name}ByteMatchAcl"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = "${aws_waf_rule.byte_match_rule.id}"
  }
}
