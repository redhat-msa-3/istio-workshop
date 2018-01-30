#!/bin/bash
rm -rf /root/projects/ /root/temp-pom.xml &> /dev/null
wget https://github.com/istio/istio/releases/download/0.4.0/istio-0.4.0-linux.tar.gz -P /root/
tar -zxvf /root/istio-0.4.0-linux.tar.gz -C /root

oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin developer
oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-egress-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z default -n istio-system

oc apply -f /root/istio-0.4.0/install/kubernetes/istio.yaml

oc expose svc istio-ingress -n istio-system

