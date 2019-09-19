# Install Flagger

Add Flagger Helm repository:

```bash
helm repo add flagger https://flagger.app
```

Output:

```text
"flagger" has been added to your repositories
```

Install Flagger's custom resource definitions:

```bash
kubectl apply -f https://raw.githubusercontent.com/weaveworks/flagger/master/artifacts/flagger/crd.yaml
```

Output:

```text
customresourcedefinition.apiextensions.k8s.io/canaries.flagger.app created
```

To install the chart with the release name `flagger` for Istio:

```bash
helm install --name flagger --namespace=istio-system flagger/flagger --version 0.18.4 --wait \
  --set crd.create="false" \
  --set logLevel="debug" \
  --set meshProvider="istio" \
  --set metricsServer="http://prometheus:9090"
```

Output:

```text
NAME:   flagger
LAST DEPLOYED: Thu Sep 19 08:22:43 2019
NAMESPACE: istio-system
STATUS: DEPLOYED

RESOURCES:
==> v1/Deployment
NAME     READY  UP-TO-DATE  AVAILABLE  AGE
flagger  1/1    1           1          20s

==> v1/Pod(related)
NAME                      READY  STATUS   RESTARTS  AGE
flagger-78957f5cf9-xxsb7  1/1    Running  0         20s

==> v1/ServiceAccount
NAME     SECRETS  AGE
flagger  1        20s

==> v1beta1/ClusterRole
NAME     AGE
flagger  20s

==> v1beta1/ClusterRoleBinding
NAME     AGE
flagger  20s


NOTES:
Flagger installed
```

Install Flagger's Grafana Helm Release:

```bash
helm install --name flagger-grafana --namespace=istio-system flagger/grafana --version 1.3.0 \
  --set password=admin \
  --set url=http://prometheus:9090 \
  --set user=admin
```

Output:

```text
NAME:   flagger-grafana
LAST DEPLOYED: Thu Sep 19 08:23:36 2019
NAMESPACE: istio-system
STATUS: DEPLOYED

RESOURCES:
==> v1/ConfigMap
NAME                         DATA  AGE
flagger-grafana-dashboards   2     0s
flagger-grafana-datasources  1     0s
flagger-grafana-providers    1     0s

==> v1/Pod(related)
NAME                              READY  STATUS             RESTARTS  AGE
flagger-grafana-66ffcb79b6-rbwpn  0/1    ContainerCreating  0         0s

==> v1/Service
NAME             TYPE       CLUSTER-IP    EXTERNAL-IP  PORT(S)  AGE
flagger-grafana  ClusterIP  10.0.145.140  <none>       80/TCP   0s

==> v1beta2/Deployment
NAME             READY  UP-TO-DATE  AVAILABLE  AGE
flagger-grafana  0/1    1           0          0s


NOTES:
1. Run the port forward command:

kubectl -n istio-system port-forward svc/flagger-grafana 3000:80

2. Navigate to:

http://localhost:3000
```

Expose `flagger-grafana` outside:

```bash
cat << EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: flagger-grafana-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http-flagger-grafana
      protocol: HTTP
    hosts:
    - flagger-grafana.${MY_DOMAIN}
  - port:
      number: 443
      name: https-flagger-grafana
      protocol: HTTPS
    hosts:
    - flagger-grafana.${MY_DOMAIN}
    tls:
      credentialName: ingress-cert-${LETSENCRYPT_ENVIRONMENT}
      mode: SIMPLE
      privateKey: sds
      serverCertificate: sds
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: flagger-grafana-virtual-service
  namespace: istio-system
spec:
  hosts:
  - flagger-grafana.${MY_DOMAIN}
  gateways:
  - flagger-grafana-gateway
  http:
  - route:
    - destination:
        host: flagger-grafana.istio-system.svc.cluster.local
        port:
          number: 80
EOF
```

Output:

```text
gateway.networking.istio.io/flagger-grafana-gateway created
virtualservice.networking.istio.io/flagger-grafana-virtual-service created
```

The Grafana with Flagger dashboards should be here: [https://flagger-grafana.myexample.dev](https://flagger-grafana.myexample.dev)
