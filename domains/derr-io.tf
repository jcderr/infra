module "derr_io" {
  source = "../modules/dns-zone"
  
  domain_name = "derr.io"
  apex_ip     = "129.146.58.44"
  
  additional_a_records = {
    "vpn"         = "83.84.178.179"
    "wiki"        = "141.144.202.177"
    "misty-river" = "141.144.202.177"
    "tracker"     = "129.146.58.44"
    "maggipicayune" = "129.146.58.44"
  }
  
  additional_cname_records = {
    "mail" = "ghs.googlehosted.com."
    "sig1._domainkey" = "sig1.dkim.derr.io.at.icloudmailadmin.com."
  }
  
  mx_records = [
    "10 mx01.mail.icloud.com.",
    "10 mx02.mail.icloud.com.",
  ]
  
  txt_records = [
    "\"apple-domain=viO7SYZOi5TVDOX5\"",
    "\"v=spf1 include:icloud.com ~all\"",
  ]
}