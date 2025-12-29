<h1 align="center">EKS Capability for Argo CD</h1>

## Guide

- AWS have announced [EKS capabilities](https://aws.amazon.com/blogs/aws/announcing-amazon-eks-capabilities-for-workload-orchestration-and-cloud-resource-management/) which include open Kubernetes solutions such as Argo CD.
- Infrastructure to deploy VPC, EKS, IAM Identity Centre User & Group and EKS capability.

## Usage
1. Ensure AWS CLI is configured.
2. `cd terraform` > `terraform init` > `terraform plan` > `terraform apply`.
3. Terraform outputs will display `server_url` where you can now access the Argo CD portal.
4. Login with the username and password from IAM Identity Centre.
5. In order to deploy applications to Argocd we need to register the EKS cluster by the following command
    ```bash
    # Get the cluster ARN
    CLUSTER_ARN=$(aws eks describe-cluster \
    --name my-cluster \
    --query 'cluster.arn' \
    --output text)

    # In order to authenticate with Argocd the standard argocd login is not supported
    # Get the Argo CD server URL from the EKS console (under your clusters Capabilities tab), or using the AWS CLI:
    export ARGOCD_SERVER=$(aws eks describe-capability \
    --cluster-name my-cluster \
    --capability-name my-argocd \
    --query 'capability.configuration.argoCd.serverUrl' \
    --output text \
    --region region-code)

    # Generate an account token from the Argo CD UI (Settings → Accounts → admin → Generate New Token), then set it as an environment variable:
    export ARGOCD_AUTH_TOKEN="your-token-here"

    # Set the required gRPC option:
    export ARGOCD_OPTS="--grpc-web"

    # Register the cluster
    argocd cluster add $CLUSTER_ARN \
    --aws-cluster-name $CLUSTER_ARN \
    --name in-cluster \
    --project default
    ```
6. Within the Argocd manifest we can now include the following
    ```yaml
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
    name: app
    namespace: argocd
    spec:
    project: default
    source:
        repoURL: xxx
        targetRevision: main
        path: xxx
    destination:
        server: <CLUSTER_ARN>
        namespace: xxx
    syncPolicy:
        automated:
        prune: true
        selfHeal: true
    ```

    Using `https://kubernetes.default.svc` won't work because the EKS capability does not automatically add the local cluster (kubernetes.default.svc) as a deployment target to deploy to the same cluster where the capability is created, explicitly register that cluster using its ARN.
7. `aws_eks_access_policy_association.argocd` Terraform resource has been created because the `AmazonEKSCapabilityArgoCDRole` role requires EKS cluster access permissions in order for us to deploy applications to Argocd. This is important otherwise you will be facing errors like the following
    ```
    Failed to load live state: failed to get cluster info for "arn:aws:eks:xxx:xxx:cluster/dualstack": error synchronizing cache state : failed to sync cluster https://xxx.xxx.prod.ccs.eks.aws.dev: failed to load initial state of resource Job.batch: failed to list resources: jobs.batch is forbidden: User "arn:aws:sts::xxx:assumed-role/AmazonEKSCapabilityArgoCDRole/aws-go-sdk-xxx"
    ```

    With the permissions as

    ```
    cannot list resource "jobs" in API group "batch" at the cluster scope

    cannot list resource "cninodes" in API group "eks.amazonaws.com" at the cluster scope
    ```

    For now `AmazonEKSClusterAdminPolicy` has been given but this can be locked down further to follow least privilege.


8. Be aware of the pricing for such feature, AWS charge the following:
   - Argo CD base charge
   - Argo CD usage charge
   - Argo CD Application hour: Each hour an Application is managed by Argo CD Capability. Each Application is counted per target cluster deployment - if you deploy one Application to 5 different clusters, this counts as 5 Applications. When using ApplicationSets with generators, each generated Application instance counts as one Application.

## References
- [Argocd Comparison AWS Blog](https://docs.aws.amazon.com/eks/latest/userguide/argocd-comparison.html)
- [EKS Pricing](https://aws.amazon.com/eks/pricing/)

## Future Scope
- How can we automatically add the cluster via Terraform so no CLI command is required. The following provider could be used [argoproj-labs](https://registry.terraform.io/providers/argoproj-labs/argocd/latest/docs) but communication to the EKS needs to be made.
