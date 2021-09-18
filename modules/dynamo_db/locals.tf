locals {
    zone_id = split("-", data.aws_availability_zones.available.zone_ids[0])[0]
    default_tag = "${var.stack}-${local.zone_id}-${var.environment}"
}