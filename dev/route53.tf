# #creating the route53 hosted zone

# resource "aws_route53_zone" "primary" {
#   name = "charanco.xyz"
# }


# #create the record set and also getting alb endpoint
# #for the jenkins record set

# resource "aws_route53_record" "tomcat" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "dev.charanco.xyz"
#   type    = "CNAME"
#   ttl     = "60"
#   records = ["${aws_lb.alb-jenkins.dns_name}"]
# }