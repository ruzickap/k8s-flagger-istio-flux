#!/bin/bash -eu

export CLOUD_PLATFORM="${CLOUD_PLATFORM:-azure}"
export TF_VAR_cloud_platform="${TF_VAR_cloud_platform:-$CLOUD_PLATFORM}"
export LETSENCRYPT_ENVIRONMENT="${LETSENCRYPT_ENVIRONMENT:-staging}"
export TF_VAR_letsencrypt_environment="${TF_VAR_letsencrypt_environment:-$LETSENCRYPT_ENVIRONMENT}"
readonly ARGS="$*"

## AWS environment variables
variable_aws() {
  export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:-AxxxxxxxxxxxxxxxxxxF}"
  export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:-Gxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/}"
  export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-eu-central-1}"
  export TF_VAR_accesskeyid="${TF_VAR_accesskeyid:-$AWS_ACCESS_KEY_ID}"
  export TF_VAR_dns_zone_name="${TF_VAR_dns_zone_name:-mylabs.dev}"
  export TF_VAR_kubernetes_cluster_name="${TF_VAR_kubernetes_cluster_name:-k8s}"
  export TF_VAR_location="${AWS_DEFAULT_REGION}"
  export TF_VAR_prefix="${USER}"
  export TF_VAR_secret_access_key="${TF_VAR_secret_access_key:-$AWS_SECRET_ACCESS_KEY}"
  export TF_VAR_vm_count="${TF_VAR_vm_count:-2}"
  export TF_VAR_vm_root_volume_size="${TF_VAR_vm_root_volume_size:-10}"
  export TF_VAR_vm_size="${TF_VAR_vm_size:-t3.large}"
  export BUCKET_NAME="${TF_VAR_prefix}-${TF_VAR_kubernetes_cluster_name}.${TF_VAR_dns_zone_name}-tfstate"
  export KEY="terraform.tfstate"
}

## Azure environment variables
variable_azure() {
  export ARM_CLIENT_ID="${ARM_CLIENT_ID:-00000000-0000-0000-0000-000000000000}"
  export ARM_CLIENT_SECRET="${ARM_CLIENT_SECRET:-00000000-0000-0000-0000-000000000000}"
  export ARM_SUBSCRIPTION_ID="${ARM_SUBSCRIPTION_ID:-00000000-0000-0000-0000-000000000000}"
  export ARM_TENANT_ID="${ARM_TENANT_ID:-00000000-0000-0000-0000-000000000000}"
  export TF_VAR_client_id="${ARM_CLIENT_ID}"
  export TF_VAR_client_secret="${ARM_CLIENT_SECRET}"
  export TF_VAR_dns_zone_name="${TF_VAR_dns_zone_name:-myexample.dev}"
  export TF_VAR_kubernetes_cluster_name="${TF_VAR_kubernetes_cluster_name:-k8s}"
  export TF_VAR_kubernetes_version="${TF_VAR_kubernetes_version:-1.14.6}"
  export TF_VAR_location="${LOCATION:-uksouth}"
  export TF_VAR_prefix="${USER}"
  export TF_VAR_resource_group_name="${TF_VAR_resource_group_name:-${TF_VAR_prefix}-${TF_VAR_kubernetes_cluster_name}-test}"
  # Resource group where Terraform can locate DNS zone (myexample.dev)
  export TF_VAR_resource_group_name_dns="${TF_VAR_resource_group_name_dns:-pruzicka-k8s-test-dns}"
  export TF_VAR_subscription_id="${ARM_SUBSCRIPTION_ID}"
  export TF_VAR_tenant_id="${ARM_TENANT_ID}"
  export TF_VAR_vm_count="${TF_VAR_vm_count:-3}"
  export TF_VAR_vm_size="${TF_VAR_vm_size:-Standard_D2_v3}"
  export STORAGE_ACCOUNT_NAME="${TF_VAR_prefix}${TF_VAR_kubernetes_cluster_name}tf"
  export CONTAINER_NAME="${TF_VAR_resource_group_name}-tfstate"
}

init_azure() {
  ## Create Terraform state backend in Azure
  # Azure login
  az login --service-principal --username "${ARM_CLIENT_ID}" --password "${ARM_CLIENT_SECRET}" --tenant "${ARM_TENANT_ID}" | jq

  if ! az group show -g "${TF_VAR_resource_group_name}" &>/dev/null; then
    # Create resource group
    az group create --name "${TF_VAR_resource_group_name}" --location "${TF_VAR_location}" | jq

    # Create storage account
    az storage account create --resource-group "${TF_VAR_resource_group_name}" --name "${STORAGE_ACCOUNT_NAME}" --sku Standard_LRS | jq

    # Create container
    az storage container create --name "${CONTAINER_NAME}" --account-name "${STORAGE_ACCOUNT_NAME}" | jq
  fi

  az logout
  rm -rf ~/.azure

  terraform init \
    -backend-config="container_name=${CONTAINER_NAME}" \
    -backend-config="storage_account_name=${STORAGE_ACCOUNT_NAME}" \
    -backend-config="resource_group_name=${TF_VAR_resource_group_name}"
}

init_aws() {
  set -eux
  if ! aws s3api head-bucket --bucket "${BUCKET_NAME}" 2>/dev/null; then
    aws s3api create-bucket --bucket "${BUCKET_NAME}" --create-bucket-configuration LocationConstraint="${AWS_DEFAULT_REGION}" | jq
    aws s3api put-bucket-encryption --bucket "${BUCKET_NAME}" --server-side-encryption-configuration='{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
  fi

  terraform init \
    -backend-config="bucket=${BUCKET_NAME}" \
    -backend-config="key=${KEY}"
}

destroy_azure() {
  az login --service-principal --username "${ARM_CLIENT_ID}" --password "${ARM_CLIENT_SECRET}" --tenant "${ARM_TENANT_ID}" | jq
  set -x
  terraform destroy -auto-approve
  rm -rf .terraform
  az group delete --yes --name "${TF_VAR_resource_group_name}"
  az logout
  rm -rf ~/.azure
}

destroy_aws() {
  set -x
  # The k8s_initial_config module needs to be removed for because Terraform can
  # not handle the modules dependencies (see aws.tf file for more details)
  # terraform destroy -target=module.k8s_initial_config -auto-approve
  terraform destroy -auto-approve
  rm -rf .terraform
  aws s3 rm "s3://${BUCKET_NAME}/${KEY}"
  aws s3api delete-bucket --bucket "${BUCKET_NAME}"
}

cmdline() {
  case "${ARGS}" in
    init)
      "init_${CLOUD_PLATFORM}"
      ;;
    destroy)
      "destroy_${CLOUD_PLATFORM}"
      ;;
    *)
      set -x
      terraform $@
      ;;
  esac
}

main() {
  cd "${CLOUD_PLATFORM}"
  "variable_${CLOUD_PLATFORM}"
  cmdline "${ARGS}"
}

main
