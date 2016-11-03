resource "aws_waf_size_constraint_set" "size_constraint_set" {
  name = "${var.name}SizeConstraintSet"

  size_constraints {
    text_transformation = "NONE"
    comparison_operator = "GT"
    size                = "15"

    field_to_match {
      type = "HEADER"
      data = "user-agent"
    }
  }
}

resource "aws_waf_rule" "size_constrant_rule" {
  name        = "${var.name}SizeConstraintRule"
  metric_name = "${var.name}SizeConstraintRule"

  predicates {
    data_id = "${aws_waf_size_constraint_set.size_constraint_set.id}"
    negated = false
    type    = "SizeConstraint"
  }
}

resource "aws_waf_web_acl" "size_constraint_acl" {
  name        = "${var.name}SizeConstraintAcl"
  metric_name = "${var.name}SizeConstraintAcl"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = "${aws_waf_rule.size_constrant_rule.id}"
  }
}
