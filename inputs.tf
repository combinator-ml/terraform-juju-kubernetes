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

// of the form: https://github.com/mlopsworks/charms/blob/main/bundle.yamlhttps://github.com/mlopsworks/charms/blob/main/bundle.yaml

variable "applications" {
  type = map(map(any))
  default = {}
}

variable "relations" {
  type = list(tuple([string, string]))
  default = []
}
