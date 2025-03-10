variable "system_short_name" {
  description = <<EOT
  (Required) Short abbreviation (to-three letters) of the system name that this resource belongs to (see naming convention guidelines).
  Will be part of the final name of the deployed resource.
  EOT
  type        = string
}

variable "app_name" {
  description = <<EOT
  (Required) Name of this resource within the system it belongs to (see naming convention guidelines).
  Will be part of the final name of the deployed resource.
  EOT
  type        = string
}

variable "environment" {
  description = "(Required) The name of the environment."
  type        = string
  validation {
    condition = contains([
      "dev",
      "test",
      "prod",
    ], var.environment)
    error_message = "Possible values are dev, test, and prod."
  }
}

# This `name` variable is replaced by the use of `system_name` and `environment` variables.
# variable "name" {
#   description = "(Required) The name which should be used for this resource. Changing this forces a new resource to be created."
#   type        = string
# }

variable "override_name" {
  description = "(Optional) Override the name of the resource. Under normal circumstances, it should not be used."
  default     = null
  type        = string
}

variable "override_location" {
  description = "(Optional) Override the location of the resource. Under normal circumstances, it should not be used."
  default     = null
  type        = string
}

variable "resource_group" {
  description = "(Required) The resource group in which to create the resource."
  type        = any
}

# This `resource_group_name` variable is replaced by the use of `resource_group` variable.
# variable "resource_group_name" {
#   description = "(Required) The name of the resource group where the resource should exist. Changing this forces a new resource to be created."
#   type        = string
# }

# This `location` variable is replaced by the use of `resource_group` variable.
# variable "location" {
#   description = "(Required) The location where the resource should exist. Changing this forces a new resource to be created."
#   type        = string
# }

variable "application_type" {
  default     = "other"
  description = "(Optional) Specifies the type of Application Insights to create. Valid values are `ios` for iOS, `java` for Java web, `MobileCenter` for App Center, `Node.JS` for Node.js, `other` for General, `phone` for Windows Phone, `store` for Windows Store and `web` for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this do not force a new resource to be created."
  type        = string
  validation {
    condition = contains([
      "ios",
      "java",
      "MobileCenter",
      "Node.JS",
      "other",
      "phone",
      "store",
      "web",
    ], var.application_type)
    error_message = "Valid options are `ios`, `java`, `MobileCenter`, `Node.JS`, `other`, `phone`, `store`, or `web`."
  }
}

variable "daily_data_cap_in_gb" {
  description = "(Optional) Specifies the Application Insights component daily data volume cap in GB."
  default     = 0.15
  type        = number
}

variable "daily_data_cap_notifications_disabled" {
  description = "(Optional) Specifies if a notification email will be send when the daily data volume cap is met."
  default     = false
  type        = bool
}

variable "retention_in_days" {
  default     = "30"
  description = "(Optional) Specifies the retention period in days. Possible values are `30`, `60`, `90`, `120`, `180`, `270`, `365`, `550` or `730`. Defaults to `30` for cost optimization instead of upstream `90`."
  type        = number
  validation {
    condition = contains([
      30,
      60,
      90,
      120,
      180,
      270,
      365,
      550,
      750,
    ], var.retention_in_days)
    error_message = "Valid options are `30`, `60`, `90`, `120`, `180`, `270`, `365`, `550` or `730`."
  }
}

variable "sampling_percentage" {
  description = "(Optional) Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry."
  default     = "100"
  type        = number
}

variable "disable_ip_masking" {
  description = "(Optional) By default the real client IP is masked as `0.0.0.0` in the logs. Use this argument to disable masking and log the real client IP. Defaults to `false`."
  default     = false
  type        = bool
}

variable "workspace_id" {
  description = "(Required) Specifies the id of a log analytics workspace resource. Changing this forces a new resource to be created."
  type        = string
}

variable "local_authentication_disabled" {
  description = "(Optional) Disable Non-Azure AD based Auth. Defaults to `false`."
  default     = false
  type        = bool
}

variable "internet_ingestion_enabled" {
  description = "(Optional) Should the Application Insights component support ingestion over the Public Internet? Defaults to `true`."
  default     = true
  type        = bool
}

variable "internet_query_enabled" {
  description = "(Optional) Should the Application Insights component support querying over the Public Internet? Defaults to `true`."
  default     = true
  type        = bool
}

variable "force_customer_storage_for_profiler" {
  description = "(Optional) Should the Application Insights component force users to create their own storage account for profiling? Defaults to `false`."
  default     = false
  type        = bool
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "web_test" {
  description = <<EOT
(Optional) The map of web test(s).
Example:
```
{
  availabilitytest-client" = {
    url  = "https://client.example.com"
    timeout       = 30
    enabled       = true
    retry_enabled = true
    geo_locations = [    # https://learn.microsoft.com/en-gb/azure/azure-monitor/app/monitor-web-app-availability#azure
      "emea-gb-db3-azr", # North Europe
      "emea-nl-ams-azr"  # West Europe
    ]
  }
}
```
EOT

  type = map(
    object({
      url           = string
      kind          = optional(string)
      frequency     = optional(number)
      timeout       = number
      enabled       = bool
      retry_enabled = bool
      geo_locations = list(string)
    })
  )
  default = {}
}
