# AWX Terraform Demo

This repository contains small Terraform examples intended to be added as an AWX Project and used by AWX Terraform Templates.

Each provider lives in its own directory:

| Directory | Provider | AWX credential type |
| --- | --- | --- |
| `aws-ec2` | AWS EC2 | Amazon Web Services (Terraform) |
| `azure-vm` | Azure VM | Microsoft Azure Resource Manager (Terraform) |
| `digitalocean-droplet` | DigitalOcean Droplet | DigitalOcean (Terraform) |
| `gcp-compute` | Google Compute Engine | Google Cloud Platform (Terraform) |
| `oci-instance` | OCI Compute Instance | Oracle Cloud Infrastructure (Terraform) |
| `proxmox-vm` | Proxmox VE VM | Proxmox VE |
| `vmware-vsphere-vm` | VMware vSphere VM | VMware vSphere (Terraform) |

## AWX Usage

1. Create an AWX Project from this Git repository.
2. Create one Terraform Template per directory.
3. Attach the matching provider credential to each template.
4. Set a target inventory and target group on each template.
5. Override variables at launch for environment-specific values.

The modules expose outputs named `host_ip_*`. AWX uses those outputs to register provisioned hosts into the target inventory when a Terraform apply completes.

## State

These examples intentionally do not define a remote backend. For production, configure a backend that matches your environment before repeated apply/destroy runs.

## Safety

No secrets are stored in this repository. Provider credentials should come from AWX credentials, and sensitive values should be provided at launch or through AWX surveys.
