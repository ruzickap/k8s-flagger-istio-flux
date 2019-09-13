# Install Flagger

Add Flagger Helm repository:

```bash
helm repo add flagger https://flagger.app
```

Install Flagger's custom resource definitions:

```bash
kubectl apply -f https://raw.githubusercontent.com/weaveworks/flagger/master/artifacts/flagger/crd.yaml
```

To install the chart with the release name `flagger` for Istio:

```bash
helm install --name flagger flagger/flagger --wait \
  --namespace=istio-system \
  --set crd.create=false \
  --set meshProvider=istio \
  --set metricsServer=http://prometheus:9090
```

Install Flagger's Grafana Helm Release:

```bash
helm install --name flagger-grafana flagger/grafana --wait \
  --namespace=istio-system \
  --set url=http://prometheus:9090 \
  --set user=admin \
  --set password=admin
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

The Grafana with Flagger dashboards should be here: [https://flagger-grafana.myexample.dev](https://flagger-grafana.myexample.dev)
