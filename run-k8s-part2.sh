#!/usr/bin/env bash

set -eu

################################################
# include the magic
################################################
test -s ./demo-magic.sh || curl --silent https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh > demo-magic.sh
. ./demo-magic.sh

################################################
# Configure the options
################################################

#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=60

# Uncomment to run non-interactively
export PROMPT_TIMEOUT=0

# No wait
export NO_WAIT=false

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "
DEMO_PROMPT="${GREEN}➜ ${CYAN}$ "

# hide the evidence
#clear

### Please run these commands before running the script

# docker run -it --rm -e USER="$USER" -e ARM_CLIENT_ID="$ARM_CLIENT_ID" -e ARM_CLIENT_SECRET="$ARM_CLIENT_SECRET" -e ARM_SUBSCRIPTION_ID="$ARM_SUBSCRIPTION_ID" -e ARM_TENANT_ID="$ARM_TENANT_ID" -e AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" -e AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK -v $SSH_AUTH_SOCK:$SSH_AUTH_SOCK -v $HOME/.config/hub:/root/.config/hub:ro -v $PWD:/mnt ubuntu
# echo $(hostname -I) $(hostname) >> /etc/hosts
# apt-get update -qq && apt-get install -qq -y curl git pv > /dev/null
# cd /mnt

# ./run-k8s-part2.sh

[ ! -d .git ] && git clone --quiet https://github.com/ruzickap/k8s-flagger-istio-flux && cd k8s-flagger-istio-flux

sed -n '/^```bash$/,/^```$/p;/^-----$/p' docs/part-0{4,5}/README.md \
| \
sed \
  -e 's/^-----$/\
p  ""\
p  "################################################################################################### Press <ENTER> to continue"\
wait\
/' \
  -e 's/^```bash.*/\
pe '"'"'/' \
  -e 's/^```$/'"'"'/' \
> README.sh


if [ "$#" -eq 0 ]; then
  ### Please run these commands before running the script

  export MY_DOMAIN=${MY_DOMAIN:-myexample.dev}
  export LETSENCRYPT_ENVIRONMENT=${LETSENCRYPT_ENVIRONMENT:-staging}
  # export LETSENCRYPT_ENVIRONMENT="production" # Use with care - Let's Encrypt will generate real certificates
  export CLOUD_PLATFORM="${CLOUD_PLATFORM:-azure}"
  # ./run-k8s-part2.sh

  export KUBECONFIG="$PWD/$(ls terraform/kubeconfig_*)"
  export FLUX_FORWARD_NAMESPACE=flux

  if [ -z ${ARM_CLIENT_ID} ] || [ -z ${ARM_CLIENT_SECRET} ] || [ -z ${ARM_SUBSCRIPTION_ID} ] || [ -z ${ARM_TENANT_ID} ]; then
    echo -e "\n*** One of the mandatory variables is not set !!\n";
    exit 1
  fi

  awk "/${MY_DOMAIN}/" /etc/hosts
  set +eux

  echo "*** ${CLOUD_PLATFORM} | ${MY_DOMAIN} | ${LETSENCRYPT_ENVIRONMENT} | ${CLOUD_PLATFORM} | ${KUBECONFIG} ***"

  echo -e "\n\n*** Press ENTER to start\n"
  read A

  # hide the evidence
  clear
  source README.sh
else
  cat README.sh
fi
