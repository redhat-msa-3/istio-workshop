#!/bin/bash
oc login -u system:admin

git clone https://github.com/redhat-developer-demos/istio-tutorial
cp -Rvf istio-tutorial/recommendations/ istio-tutorial/recommendations-v2
git apply /root/recommendations-v2.diff --directory=/root/istio-tutorial || { echo "Git apply failed. Check file recommendations-v2.diff"; exit 1; }
rm /root/recommendations-v2.diff
oc new-project tutorial
oc adm policy add-scc-to-user privileged -z default -n tutorial

#Package Projects
mvn package -f /root/istio-tutorial/customer/ -DskipTests
mvn package -f /root/istio-tutorial/recommendations/ -DskipTests
mvn package -f /root/istio-tutorial/recommendations-v2/ -DskipTests
mvn package -f /root/istio-tutorial/preferences/ -DskipTests


#Docker build
docker build -t example/customer /root/istio-tutorial/customer/
docker build -t example/preferences /root/istio-tutorial/preferences/
docker build -t example/recommendations:v1 /root/istio-tutorial/recommendations/
docker build -t example/recommendations:v2 /root/istio-tutorial/recommendations-v2/

#Deploy to OpenShift
oc apply -f <(/root/istio-0.4.0/bin/istioctl kube-inject -f /root/istio-tutorial/customer/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/istio-0.4.0/bin/istioctl kube-inject -f /root/istio-tutorial/preferences/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/istio-0.4.0/bin/istioctl kube-inject -f /root/istio-tutorial/recommendations/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/istio-0.4.0/bin/istioctl kube-inject -f /root/istio-tutorial/kubernetesfiles/recommendations_v2_deployment.yml) -n tutorial

oc create -f /root/istio-tutorial/customer/src/main/kubernetes/Service.yml
oc create -f /root/istio-tutorial/preferences/src/main/kubernetes/Service.yml
oc create -f /root/istio-tutorial/recommendations/src/main/kubernetes/Service.yml

oc expose service customer -n tutorial


