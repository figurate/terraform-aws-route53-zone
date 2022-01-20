module "zone" {
  source = "../.."

  name     = var.name
  vpc_name = var.vpc_name
  records  = var.records
  aliases  = var.aliases
}
