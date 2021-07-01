# Deploy Sample-CIAM using Helm

Helm is a package deployment tool for Kubernetes. It can be used with [Sample-CIAM](../Kubernetes) to deploy all the components of the Solution with a simple command.

1. Inject your Ping Devops information into your k8s namespace

    ```shell
    {{k8s cluster domain}} generate devops-secret | kubectl apply -f -
    ```

2. Install Helm

    ```shell
    brew install helm
    ```

3. Add Helm Repo

    ```shell
    helm repo add sampleCiam https://cprice-ping.github.io/Sample-CIAM
    ```

4. List Ping Solutions Charts

    ```shell
    helm search repo
    ```

5. Update local machine with latest charts

    ```shell
    helm repo update
    ```

6. Stand vanilla config (No Admin SSO \ No P1 Services)

    ```shell
    helm install {{Release Name}} sampleCiam/ping-sample-ciam
    ```

7. Create a [values.yaml](./values.yaml) file - PingOne integration (My Ping | PingOne Services)

8. Install Sample-CIAM with values

    ```shell
    helm install {{Release Name}} sampleCiam/ping-sample-ciam -f values.yaml
    ```

## Accessing Deployments

Components of the release will be prefixed with your `{{Release Name}}`

Once installed, use `kubectl` to access the workloads:

View Services / Pods:

```shell
kubectl get pods | services
```

View Logs:

```shell
kubectl logs -f service/{{Release Name}}-{{Product}}
```

For example:

```hell
`kubectl logs -f service/myname-myrelease-pingfederate-engine
```

View configuration API calls:

```shell
kubectl logs -f job/{{Release Name}}-pingconfig
```

### Admin Console URLs

Deployed Admin consoles URLs will be displayed in NOTES.txt.

Sample URLs:

`https://{{Product}}-{{Release Name}}.{{k8s cluster domain}}.com`

| Ping Product | Admin Console URL |
| ----- | ----- |
| PingFederate | `https://pingfederate-{{Release Name}}.{{k8s cluster domain}}.com/pingfederate` |
| PingDirectory | `https://pingdataconsole-{{Release Name}}.{{k8s cluster domain}}.com` |
| PingDataSync | `https://pingdataconsole-{{Release Name}}.{{k8s cluster domain}}.com` |
