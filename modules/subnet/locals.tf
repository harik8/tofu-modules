locals {
  default_tag  = "${var.stack}-${local.zone_id}-${var.environment}"
  num_of_zones = length(data.aws_availability_zones.available.names)
  zone_id      = split("-", data.aws_availability_zones.available.zone_ids[0])[0]

  zones = data.aws_availability_zones.available.names
}