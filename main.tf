/**
 * # AWS Route53 Zone
 *
 * ![AWS Route53 Zone](aws_route53_zone.png)
 *
 * ![main workflow](https://github.com/figurate/terraform-aws-route53-zone/actions/workflows/main.yml/badge.svg)
 */
data "aws_vpc" "vpc" {
  count = var.vpc_name != null ? 1 : 0
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

resource "aws_route53_zone" "zone" {
  name = var.name
  dynamic "vpc" {
    for_each = var.vpc_name != null ? [1] : []
    content {
      vpc_id = data.aws_vpc.vpc[0].id
    }
  }
}

resource "aws_route53_record" "record" {
  count   = length(var.records)
  name    = var.records[count.index][0]
  type    = var.records[count.index][1]
  records = var.records[count.index][2]
  ttl     = 300
  zone_id = aws_route53_zone.zone.id
}

resource "aws_route53_record" "alias" {
  #checkov:skip=CKV2_AWS_23:A record attached resource specified at root level
  count = length(var.aliases)
  name  = var.aliases[count.index][0]
  type  = "A"
  alias {
    evaluate_target_health = false
    name                   = var.aliases[count.index][1]
    zone_id                = var.aliases[count.index][2]
  }
  zone_id = aws_route53_zone.zone.id
}
