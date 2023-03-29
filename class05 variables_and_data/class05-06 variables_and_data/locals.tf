
# company_name-project_name-cost_cent-project_code
#pagecloud-terraform-10101-2023-03
locals {
  common_tags =  {
    resource_name = "${var.company_name}-${var.project_name}-${var.cost_center}-${var.project_code}"
    team = var.team
    deparment = var.department
  }
}
