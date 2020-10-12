# terraform-gcp-dns-seems

## Kubernetes External DNS

### Variables
```
cluster_name="ChangeMe!"

iam_name="$cluster_name-external-dns"
iam_display_name="Kubernetes External DNS"

project_name="ChangeMe!"
```

### IAM Service Account
```bash
gcloud iam service-accounts create "$iam_name" \
    --display-name="$iam_display_name"
```

### Get IAM Service Account Email
```bash
iam_email=$(gcloud iam service-accounts list \
    --format='value(email)' \
    --filter="displayName:$iam_display_name")
```

### `wait few second!`

### Add IAM Policy Binding
```bash
gcloud projects add-iam-policy-binding "$project_name" \
    --member="serviceAccount:$iam_email" \
    --role=roles/dns.admin
```

### IAM Service Account Add IAM Policy Binding 
```bash
gcloud iam service-accounts add-iam-policy-binding "$iam_email" \
    --member="serviceAccount:$project_name.svc.id.goog[external-dns/external-dns]" \
    --role=roles/iam.workloadIdentityUser
```

### Create Cluster Role Binding
```bash
kubectl create clusterrolebinding cluster-admin-me \
    --clusterrole=cluster-admin \
    --user="$(gcloud config get-value account)"

### Deploy External DNS
```bash
apiVersion: v1
kind: Namespace
metadata:
  name: external-dns
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: external-dns
  namespace: external-dns
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: external-dns
rules:
  - apiGroups: [""]
    resources: ["services", "endpoints", "pods"]
    verbs: ["get", "watch", "list"]
  - apiGroups: ["extensions", "networking.k8s.io"]
    resources: ["ingresses"]
    verbs: ["get", "watch", "list"]
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: external-dns-viewer
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: external-dns
subjects:
  - kind: ServiceAccount
    name: external-dns
    namespace: external-dns
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: external-dns
  namespace: external-dns
spec:
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: external-dns
  template:
    metadata:
      labels:
        app: external-dns
    spec:
      containers:
        - args:
            - --source=ingress
            - --source=service
            - --domain-filter=seems.cloud.
            - --provider=google
            - --google-project=molten-infusion-277321
            - --registry=txt
            - --txt-owner-id=my-identifier
          image: k8s.gcr.io/external-dns/external-dns:v0.7.3
          name: external-dns
      securityContext:
        fsGroup: 65534
        runAsUser: 65534
      serviceAccountName: external-dns
```

### Annotate Service Account
```bash
kubectl annotate serviceaccount \
    --namespace=external-dns external-dns "iam.gke.io/gcp-service-account=$iam_email"
```