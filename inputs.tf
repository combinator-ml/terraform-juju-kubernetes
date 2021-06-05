variable "name" {
  type = string
  default = "bundle"
}

variable "kubeconfig" {
  // the contents of a kubeconfig file onto which to bootstrap juju and
  // provision the given bundle
  type = string
}

variable "bundle" {
  type = string
  default = "kubernetes"
}

variable "description" {
  type = string
  default = "Bundle description"
}

variable "applications" {
  type = map(map(any))
  default = {}
}

variable "relations" {
  type = list(tuple([string, string]))
  default = []
}
