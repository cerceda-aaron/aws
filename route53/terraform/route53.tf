resource "aws_route53_zone" "primary" {
  name = "zedillowhitehouse.click"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "app.zedillowhitehouse.click"
  type = "A"
  ttl = 300

  records = ["203.0.113.10"]
}