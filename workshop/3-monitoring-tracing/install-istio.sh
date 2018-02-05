#!/bin/bash
rm -rf /root/projects/* /root/temp-pom.xml
echo "Downloading Istio installation"
wget https://github.com/istio/istio/releases/download/0.5.0/istio-0.5.0-linux.tar.gz -P /root/ &> /dev/null || { echo "Failed to Download Istio installation"; exit 1; }
echo "Uncompressing Istio installation"
tar -zxvf /root/istio-0.5.0-linux.tar.gz -C /root &> /dev/null || { echo "Failed to Download Istio installation"; exit 1; }

oc login -u system:admin &> /dev/null
oc adm policy add-cluster-role-to-user cluster-admin developer
oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-egress-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z default -n istio-system

echo "Deploying Istio installation into OpenShift"
oc apply -f /root/istio-0.5.0/install/kubernetes/istio.yaml || { echo "Failed to Download Istio installation"; exit 1; }

oc expose svc istio-ingress -n istio-system &> /dev/null
echo "Istio installed"

