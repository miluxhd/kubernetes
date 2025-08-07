#!/bin/bash

echo "=== Helm Lookup API Evaluation ==="

echo "Creating custom-nginx deployment with annotations..."
kubectl create deployment custom-nginx --image=nginx --dry-run=client -o yaml | kubectl apply -f -
kubectl patch deployment custom-nginx -p '{"metadata":{"annotations":{"demo.annotation":"test-value","helm.example":"lookup-demo","custom.key":"custom-value"}}}'
echo
echo "Installing..."
helm upgrade --install demo-eval .
echo
echo "ConfigMap:"
kubectl get configmap demo-eval-api-results -o yaml

echo
echo "Uninstalling..."
helm uninstall demo-eval
kubectl delete deployment custom-nginx
