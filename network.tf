module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 7.0"

    project_id = var.project_id

    network_name = "webserver"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "webserver"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = var.region
        }
    ]

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        },
    ]

    firewall_rules = [{
        name = "allow-443"
        direction = "INGRESS"
        ranges = ["0.0.0.0/0"]
        target_tags   = ["allow-https"]
        allow = [{
            protocol = "tcp"
            ports = [443]
        }]
    },{
        name = "allow-ssh"
        direction = "INGRESS"
        ranges = ["0.0.0.0/0"]
        target_tags   = ["allow-ssh"]
        allow = [{
            protocol = "tcp"
            ports = [22]
        }]
    }]

    depends_on = [ google_project_service.api ]
}
