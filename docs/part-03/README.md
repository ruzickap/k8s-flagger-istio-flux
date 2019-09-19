# Install Tekton and build pipelines

Create registry secret for accessing Azure Container Registry:

```bash
kubectl create secret docker-registry docker-config \
  --docker-server="pruzickak8smyexampledev.azurecr.io" \
  --docker-username="${ARM_CLIENT_ID}" \
  --docker-password="${ARM_CLIENT_SECRET}"
```

Install Tekton with Dashboard:

```bash
envsubst < files/flux-repository/workloads/tekton.yaml           > tmp/k8s-flux-repository/workloads/tekton.yaml
envsubst < files/flux-repository/workloads/tekton-dashboard.yaml > tmp/k8s-flux-repository/workloads/tekton-dashboard.yaml
envsubst < files/flux-repository/workloads/tekton-services.yaml  > tmp/k8s-flux-repository/workloads/tekton-services.yaml

git -C tmp/k8s-flux-repository add --verbose .
git -C tmp/k8s-flux-repository commit -m "Add Tekton"
git -C tmp/k8s-flux-repository push -q
sleep 10 # Prevent errors like: Error: git repository git@github.com:ruzickap/k8s-flux-repository is not ready to sync (status: cloned)
fluxctl sync
```

Prepare Tekton pipelines:

```bash
envsubst < files/flux-repository/workloads/tekton-pipelineresource.yaml > tmp/k8s-flux-repository/workloads/tekton-pipelineresource.yaml
envsubst < files/flux-repository/workloads/tekton-task-pipeline.yaml    > tmp/k8s-flux-repository/workloads/tekton-task-pipeline.yaml
git -C tmp/k8s-flux-repository add --verbose .
git -C tmp/k8s-flux-repository commit -m "Add pipelines and pipelineresources"
git -C tmp/k8s-flux-repository push -q
fluxctl sync
```

Initiate `PipelineRun` which builds container image form git repository:

```bash
envsubst < files/flux-repository/workloads/tekton-pipelinerun.yaml      > tmp/k8s-flux-repository/workloads/tekton-pipelinerun.yaml
git -C tmp/k8s-flux-repository add --verbose .
git -C tmp/k8s-flux-repository commit -m "Add pipeline and initiate build process"
git -C tmp/k8s-flux-repository push -q
fluxctl sync
```

Check if the build of docker image was completed:

```bash
kubectl wait --timeout=10m --for=condition=Succeeded pipelineruns/podinfo-build-docker-image-from-git-pipelinerun
kubectl get pipelineruns podinfo-build-docker-image-from-git-pipelinerun
```

Output:

```text
NAME                                              SUCCEEDED   REASON      STARTTIME   COMPLETIONTIME
podinfo-build-docker-image-from-git-pipelinerun   True        Succeeded   7m48s       2m30s
```
