# Install Harbor using Flux and build containers

## Harbor

Install Harbor:

```bash
envsubst < files/flux-repository/namespaces/harbor-ns.yaml      > tmp/k8s-flux-repository/namespaces/harbor-ns.yaml
envsubst < files/flux-repository/releases/harbor-release.yaml   > tmp/k8s-flux-repository/releases/harbor-release.yaml
envsubst < files/flux-repository/workloads/harbor-services.yaml > tmp/k8s-flux-repository/workloads/harbor-services.yaml

git -C tmp/k8s-flux-repository add --verbose .
git -C tmp/k8s-flux-repository commit -m "Add Harbor"
git -C tmp/k8s-flux-repository push -q
fluxctl sync
```

Output:

```text
add 'namespaces/harbor-ns.yaml'
add 'releases/harbor-release.yaml'
add 'workloads/harbor-services.yaml'
[master dd95b25] Add Harbor
 3 files changed, 119 insertions(+)
 create mode 100644 namespaces/harbor-ns.yaml
 create mode 100644 releases/harbor-release.yaml
 create mode 100644 workloads/harbor-services.yaml
Synchronizing with git@github.com:ruzickap/k8s-flux-repository
Revision of master to apply is dd95b25
Waiting for dd95b25 to be applied ...
Done.
```

## Install Tekton

Install Tekton with Dashboard:

```bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/latest/release.yaml
```

```bash
export GIT_REPOSITORY="https://github.com/stefanprodan/podinfo.git"
export GIT_REVISION="v1.7.0"
export CONTAINER_REGISTRY="harbor.${MY_DOMAIN}/library/podinfo"
export CONTAINER_REGISTRY_USERNAME="admin"
export CONTAINER_REGISTRY_PASSWORD="admin"
###
export GIT_PROJECT_NAME=$( echo ${GIT_REPOSITORY} | sed "s@.*/\(.*\).git@\1@; s/\./\-/" )
export CONTAINER_REGISTRY_SERVER=$( echo $CONTAINER_REGISTRY | awk -F / "{ print \$1 }" )
export CONTAINER_REGISTRY_SERVER_MODIFIED=$( echo $CONTAINER_REGISTRY | awk -F / "{ gsub(/\./,\"-\"); print \$1 }" )
```

```bash
kubectl create secret docker-registry ${CONTAINER_REGISTRY_SERVER_MODIFIED}-docker-config --docker-server="${CONTAINER_REGISTRY_SERVER}" --docker-username="${CONTAINER_REGISTRY_USERNAME}" --docker-password="${CONTAINER_REGISTRY_PASSWORD}"
```

```bash
cat << EOF | kubectl apply -f -
apiVersion: tekton.dev/v1alpha1
kind: PipelineResource
metadata:
  name: ${GIT_PROJECT_NAME}-project-git
  namespace: default
spec:
  type: git
  params:
    - name: url
      value: ${GIT_REPOSITORY}
    - name: revision
      value: ${GIT_REVISION}
---
apiVersion: tekton.dev/v1alpha1
kind: PipelineResource
metadata:
  name: ${GIT_PROJECT_NAME}-project-image
spec:
  type: image
  params:
    - name: url
      value: ${CONTAINER_REGISTRY}:${GIT_REVISION}
---
apiVersion: tekton.dev/v1alpha1
kind: Task
metadata:
  name: build-docker-image-from-git-task
spec:
  inputs:
    resources:
      - name: docker-source
        type: git
    params:
      - name: pathToDockerFile
        description: The path to the dockerfile to build
        default: /workspace/docker-source/Dockerfile
      - name: pathToContext
        description:
          The build context used by Kaniko
          (https://github.com/GoogleContainerTools/kaniko#kaniko-build-contexts)
        default: /workspace/docker-source
  outputs:
    resources:
      - name: builtImage
        type: image
  volumes:
    - name: docker-config
      secret:
        secretName: ${CONTAINER_REGISTRY_SERVER_MODIFIED}-docker-config
        items:
          - key: .dockerconfigjson
            path: config.json
  steps:
    - name: build-and-push
      image: gcr.io/kaniko-project/executor
      env:
        - name: "DOCKER_CONFIG"
          value: "/builder/home/.docker/"
      command:
        - /kaniko/executor
      args:
        - --dockerfile=\${inputs.params.pathToDockerFile}
        - --destination=\${outputs.resources.builtImage.url}
        - --context=\${inputs.params.pathToContext}
        - --skip-tls-verify
      volumeMounts:
        - name: docker-config
          mountPath: /builder/home/.docker/
---
apiVersion: tekton.dev/v1alpha1
kind: Pipeline
metadata:
  name: build-docker-image-from-git-pipeline
spec:
  resources:
  - name: docker-source
    type: git
  - name: builtImage
    type: image
  tasks:
  - name: build-docker-image-from-git-task-run
    taskRef:
      name: build-docker-image-from-git-task
    params:
    - name: pathToDockerFile
      value: Dockerfile.ci
    - name: pathToContext
      value: /workspace/docker-source/
    resources:
      inputs:
      - name: docker-source
        resource: docker-source
      outputs:
      - name: builtImage
        resource: builtImage
---
apiVersion: tekton.dev/v1alpha1
kind: PipelineRun
metadata:
  name: ${GIT_PROJECT_NAME}-build-docker-image-from-git-pipelinerun
spec:
  pipelineRef:
    name: build-docker-image-from-git-pipeline
  resources:
    - name: docker-source
      resourceRef:
        name: ${GIT_PROJECT_NAME}-project-git
    - name: builtImage
      resourceRef:
        name: ${GIT_PROJECT_NAME}-project-image
EOF
```
