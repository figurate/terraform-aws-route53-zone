## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aliases | A list of aliases (FQDN, target dns, target zone) | `list(tuple([string, string, string]))` | `[]` | no |
| name | Route53 Zone name | `any` | n/a | yes |
| records | A list of records (FQDN, record type, target addresses) | `list(tuple([string, string, list(string)]))` | `[]` | no |

## Outputs

No output.

