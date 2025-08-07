# Lookup API Example

This Helm chart demonstrates the usage of Helm's `lookup` function to query Kubernetes resources during chart rendering.

## What it does

1. Looking up a Deployment named `custom-nginx` in the `default` namespace
2. Extracting annotation values from that Deployment
3. Storing the results in a ConfigMap

## Prerequisites

- Kubernetes cluster
- Helm 3.x
- kubectl configured to access your cluster

## Usage

### Quick Start

Run the evaluation script to see the lookup API in action:

```bash
./evaluate.sh
```

This script will:
1. Create a test deployment with annotations
2. Install the Helm chart
3. Display the resulting ConfigMap
4. Clean up the resources

### Manual Installation

1. Create a test deployment with annotations:
```bash
kubectl create deployment custom-nginx --image=nginx
kubectl patch deployment custom-nginx -p '{"metadata":{"annotations":{"demo.annotation":"test-value","helm.example":"lookup-demo","custom.key":"custom-value"}}}'
```

2. Install the chart:
```bash
helm install demo-eval .
```

3. Check the results:
```bash
kubectl get configmap demo-eval-api-results -o yaml
```

4. Clean up:
```bash
helm uninstall demo-eval
kubectl delete deployment custom-nginx
```

## Use Cases

The lookup API is useful for:
- Reading configuration from existing resources
- Cross-referencing data between different resources
- Dynamic configuration based on cluster state
- Integration with existing Kubernetes resources
