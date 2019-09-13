# Clean-up

![Clean-up](https://raw.githubusercontent.com/aws-samples/eks-workshop/65b766c494a5b4f5420b2912d8373c4957163541/static/images/cleanup.svg?sanitize=true
"Clean-up")

Configure `kubeconfig`:

```bash
export MY_DOMAIN="myexample.dev"
export KUBECONFIG="$PWD/$(ls terraform/kubeconfig_*)"
```

Remove DNS records:

```bash
kubectl delete gateways.networking.istio.io --all --all-namespaces
kubectl delete pod -n external-dns --all
sleep 10
```

Delete GitHub repository:

```bash
hub delete -y ruzickap/k8s-flux-repository
```

Output:

```text
Deleted repository 'ruzickap/k8s-flux-repository'.
```

Remove AKS cluster:

```bash
cd terraform
./terraform-azure.sh destroy
cd ..
```

Cleanup + Remove Helm:

```bash
rm -rf /home/${USER}/.helm
```

Remove `tmp` directory:

```bash
rm -rf tmp
```

Remove other files:

```bash
rm demo-magic.sh README.sh &> /dev/null
```
