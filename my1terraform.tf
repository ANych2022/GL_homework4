1. LAMP+Wordpress via UI

2. LAMP+Wordpress via Terraform

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("/home/andriy_nychyporuk/homework4-372210-0af64eef39ff.json")

  project = "homework4-372210"
  region  = "us-central1"
  zone    = "us-central1-c"
}


resource "google_compute_instance" "vm_instance" {
  name         = "lamp2"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

    metadata = {
     "startup-script" = <<-EOF
    sudo mkdir -p /var/www/html/
    sudo echo "<h2>HOMEWORK4<h2>" > /var/www/html/index.html
    sudo apt-get update -y
    sudo apt-get install apache2 php libapache2-mod-php
    sudo apt-get install mariadb-server php php-mysql
    sudo apt-get install wget -y
    sudo wget https://wordpress.org/latest.tar.gz
    sudo tar xzvf latest.tar.gz

    sudo chown -R www-data:www-data /var/www/html/wordpress/

    sudo service apache2 restart
    EOF
    }
}
