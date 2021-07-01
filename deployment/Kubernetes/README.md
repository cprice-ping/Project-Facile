# Kubernetes Deployment

## Pre-requisites

* Access to a Kuberenetes Cluster \ Namespace
* Ping GSA DevOps toolkit -- `brew install ping-devops`
* Create your DevOps secret file and inject into your namespace

    ```bash
    ping-devops generate devops-secret | kubectl apply -f -
    ```

You'll use this file in all your deployments  
**NOTE:**  Be careful not to upload to GitHub in your Profile(s)

* Install Helm -- `brew install helm`
