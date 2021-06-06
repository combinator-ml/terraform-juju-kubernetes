resource "random_id" "random" {
    byte_length = 8
}

resource "local_file" "kubeconfig" {
    content = var.kubeconfig
    filename = "${path.module}/${random_id.random.hex}/kubeconfig"
}

resource "local_file" "bundle_yaml" {
    content = yamlencode({
      "applications": var.applications,
      "bundle": var.bundle,
      "description": var.description,
      "relations": var.relations,
    })
    filename = "${path.module}/${random_id.random.hex}/bundle.yaml"
}

resource "null_resource" "testfaster_vm" {
    depends_on = [local_file.bundle_yaml, local_file.kubeconfig]
    provisioner "local-exec" {
        command = <<-EOT
            cd ${path.module}/${random_id.random.hex}
            export KUBECONFIG=$(pwd)/kubeconfig
            snap install juju --classic --channel=2.9/stable
            /snap/bin/juju add-k8s --client k8s
            # Use clusterIP service type and then hopefully juju will
            # port-forward to it https://github.com/juju/juju/pull/12512
            /snap/bin/juju bootstrap k8s --config controller-service-type=cluster
            /snap/bin/juju deploy bundle.yaml
        EOT
    }
}

// TODO: outputs, such as DNS names for services created?
