output "kubeconfig_export_command" {
  value = "'export KUBECONFIG=$PWD/${basename(local_file.file.filename)}'"
}
