terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.16.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine" # Comenta esta linea si eres usuario MacOS o Linux
}

resource "docker_image" "microapp" {
  name = "microapp"
  build {
    path = "../../cj-myAPI-microservicio-a/."
    tag = [
      "microapp:latest"
    ]
  }
}

resource "docker_container" "serpiente" {
  image = docker_image.microapp.latest
  name  = "serpiente"
  ports {
    internal = 5000
    external = 5000
  }
  depends_on = [
    docker_image.microapp
  ]
}