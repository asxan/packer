packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "1.1.4"
    }
  }
}


variable "project_id" {
  type        = string
  description = "The project id for which will be created images"
  default     = "asxan-project"
}


variable "availability_zone" {
  type        = string
  description = "The availability zone"
  default     = "europe-west3-a"
}


variable "source_image" {
  type        = string
  description = "The source image for building"
  default     = "centos-7-v20210916"
}

variable "image_family" {
  type        = string
  description = "Image family"
  default     = "centos-7"
}

variable "ssh_user" {
  type        = string
  description = "SSH user"
  default     = "asxan_agrail"
}

source "googlecompute" "centos-nginx" {
  project_id          = "${var.project_id}"
  zone                = "${var.availability_zone}"
  source_image        = "${var.source_image}"
  source_image_family = "${var.image_family}"
  ssh_username        = "${var.ssh_user}"
  image_name          = "nginx-${var.image_family}"
  image_description   = "nginx centos-7 gce image"
}

build {
  sources = ["source.googlecompute.centos-nginx"]

  provisioner "shell" {
    script = "scripts/nginx-installation.sh"
  }

  post-processors {
    post-processor "checksum" {
      checksum_types = ["sha1", "sha256"]
      output         = "packer_{{.BuildName}}_{{.ChecksumType}}.checksum"
    }
  }
}