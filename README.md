# [terraform-azurerm-applicationinsights][1]

Manages an Application Insights component.

Note: Classic Applications Insights will be retired on 29 February 2024.

- [We’re retiring Classic Application Insights on 29 February 2024.](https://azure.microsoft.com/en-us/updates/we-re-retiring-classic-application-insights-on-29-february-2024/)
- [Classic application insights will be retired on 29 February 2024—migrate to workspace-based application insights.](https://learn.microsoft.com/en-us/answers/questions/1339195/classic-application-insights-will-be-retired-on-29)

## Getting Started

- Format and validate Terraform code before commit.

```shell
terraform init -upgrade \
    && terraform init -reconfigure -upgrade \
    && terraform fmt -recursive . \
    && terraform fmt -check \
    && terraform validate .
```

- Always fetch latest changes from upstream and rebase from it. Terraform documentation will always be updated with GitHub Actions. See also [.github/workflows/terraform.yml](.github/workflows/terraform.yml) GitHub Actions workflow.

```shell
git fetch --all --tags --prune --prune-tags \
  && git pull --rebase --all --prune --tags
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.14.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.14.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_application_insights_web_test.web_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_web_test) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | (Required) Name of this resource within the system it belongs to (see naming convention guidelines).<br/>  Will be part of the final name of the deployed resource. | `string` | n/a | yes |
| <a name="input_application_type"></a> [application\_type](#input\_application\_type) | (Optional) Specifies the type of Application Insights to create. Valid values are `ios` for iOS, `java` for Java web, `MobileCenter` for App Center, `Node.JS` for Node.js, `other` for General, `phone` for Windows Phone, `store` for Windows Store and `web` for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this do not force a new resource to be created. | `string` | `"other"` | no |
| <a name="input_daily_data_cap_in_gb"></a> [daily\_data\_cap\_in\_gb](#input\_daily\_data\_cap\_in\_gb) | (Optional) Specifies the Application Insights component daily data volume cap in GB. | `number` | `0.15` | no |
| <a name="input_daily_data_cap_notifications_disabled"></a> [daily\_data\_cap\_notifications\_disabled](#input\_daily\_data\_cap\_notifications\_disabled) | (Optional) Specifies if a notification email will be send when the daily data volume cap is met. | `bool` | `false` | no |
| <a name="input_disable_ip_masking"></a> [disable\_ip\_masking](#input\_disable\_ip\_masking) | (Optional) By default the real client IP is masked as `0.0.0.0` in the logs. Use this argument to disable masking and log the real client IP. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The name of the environment. | `string` | n/a | yes |
| <a name="input_force_customer_storage_for_profiler"></a> [force\_customer\_storage\_for\_profiler](#input\_force\_customer\_storage\_for\_profiler) | (Optional) Should the Application Insights component force users to create their own storage account for profiling? Defaults to `false`. | `bool` | `false` | no |
| <a name="input_internet_ingestion_enabled"></a> [internet\_ingestion\_enabled](#input\_internet\_ingestion\_enabled) | (Optional) Should the Application Insights component support ingestion over the Public Internet? Defaults to `true`. | `bool` | `true` | no |
| <a name="input_internet_query_enabled"></a> [internet\_query\_enabled](#input\_internet\_query\_enabled) | (Optional) Should the Application Insights component support querying over the Public Internet? Defaults to `true`. | `bool` | `true` | no |
| <a name="input_local_authentication_disabled"></a> [local\_authentication\_disabled](#input\_local\_authentication\_disabled) | (Optional) Disable Non-Azure AD based Auth. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_override_location"></a> [override\_location](#input\_override\_location) | (Optional) Override the location of the resource. Under normal circumstances, it should not be used. | `string` | `null` | no |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | (Optional) Override the name of the resource. Under normal circumstances, it should not be used. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Required) The resource group in which to create the resource. | `any` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | (Optional) Specifies the retention period in days. Possible values are `30`, `60`, `90`, `120`, `180`, `270`, `365`, `550` or `730`. Defaults to `30` for cost optimization instead of upstream `90`. | `number` | `"30"` | no |
| <a name="input_sampling_percentage"></a> [sampling\_percentage](#input\_sampling\_percentage) | (Optional) Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry. | `number` | `"100"` | no |
| <a name="input_system_short_name"></a> [system\_short\_name](#input\_system\_short\_name) | (Required) Short abbreviation (to-three letters) of the system name that this resource belongs to (see naming convention guidelines).<br/>  Will be part of the final name of the deployed resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_web_test"></a> [web\_test](#input\_web\_test) | (Optional) The map of web test(s).<br/>Example:<pre>{<br/>  availabilitytest-client" = {<br/>    url  = "https://client.example.com"<br/>    timeout       = 30<br/>    enabled       = true<br/>    retry_enabled = true<br/>    geo_locations = [    # https://learn.microsoft.com/en-gb/azure/azure-monitor/app/monitor-web-app-availability#azure<br/>      "emea-gb-db3-azr", # North Europe<br/>      "emea-nl-ams-azr"  # West Europe<br/>    ]<br/>  }<br/>}</pre> | <pre>map(<br/>    object({<br/>      url           = string<br/>      kind          = optional(string)<br/>      frequency     = optional(number)<br/>      timeout       = number<br/>      enabled       = bool<br/>      retry_enabled = bool<br/>      geo_locations = list(string)<br/>    })<br/>  )</pre> | `{}` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | (Required) Specifies the id of a log analytics workspace resource. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_application_insights"></a> [azurerm\_application\_insights](#output\_azurerm\_application\_insights) | The Azure Application Insights resource. |
| <a name="output_azurerm_application_insights_web_test"></a> [azurerm\_application\_insights\_web\_test](#output\_azurerm\_application\_insights\_web\_test) | The Azure Application Insights Web Test resource. |
<!-- END_TF_DOCS -->

[1]: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights
