# EKS (Elastic Kubernetes Service)

## Commands
#### update kube config
```bash
just update-kubeconfig
```
#### Allow user to view k8s resources in console
```bash
kubectl edit configmap aws-auth -n kube-system
```
Add the following to the configmap and save.
```yaml
mapRoles: |
    ...
    - groups:
      - system:masters
      rolearn: arn:aws:iam::<ACCOUNT>:role/<ROLE_NAME>
      username: <USERNAME>
```
