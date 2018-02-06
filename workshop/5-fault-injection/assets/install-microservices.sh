#!/bin/bash
git --git-dir=/root/projects/istio-tutorial/.git pull
cp -Rvf /root/projects/istio-tutorial/recommendation/ /root/projects/istio-tutorial/recommendation-v2
git apply /root/recommendation-v2.diff --directory=/root/projects/istio-tutorial/

oc login -u system:admin

oc new-project tutorial
oc adm policy add-scc-to-user privileged -z default -n tutorial
mvn package -f /root/projects/istio-tutorial/customer/ -DskipTests
mvn package -f /root/projects/istio-tutorial/preference/ -DskipTests
mvn package -f /root/projects/istio-tutorial/recommendation/ -DskipTests
mvn package -f /root/projects/istio-tutorial/recommendation-v2/ -DskipTests

docker build -t example/customer /root/projects/istio-tutorial/customer/
docker build -t example/preference /root/projects/istio-tutorial/preference/
docker build -t example/recommendation:v1 /root/projects/istio-tutorial/recommendation/
docker build -t example/recommendation:v2 /root/projects/istio-tutorial/recommendation-v2/

oc apply -f <(/root/installation/istio-0.5.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/customer/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/installation/istio-0.5.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/preference/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/installation/istio-0.5.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/recommendation/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/installation/istio-0.5.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial//kubernetesfiles/recommendation_v2_deployment.yml) -n tutorial

oc create -f /root/projects/istio-tutorial/customer/src/main/kubernetes/Service.yml -n tutorial
oc create -f /root/projects/istio-tutorial/preference/src/main/kubernetes/Service.yml -n tutorial
oc create -f /root/projects/istio-tutorial/recommendation-v1/src/main/kubernetes/Service.yml -n tutorial

oc expose service customer -n tutorial