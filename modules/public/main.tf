module "zone" {
  source = "../.."

  name    = var.name
  records = var.records
  aliases = var.aliases
}
