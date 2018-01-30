#!/bin/bash
oc new-project tutorial
oc adm policy add-scc-to-user privileged -z default -n tutorial

#Package Projects
echo "Building customer with Maven. First Maven build takes a while"
mvn package -f /root/istio-tutorial/customer/ -DskipTests &> /dev/null || { echo "Error building customer"; exit 1; }
echo "Building preferences with Maven"
mvn package -f /root/istio-tutorial/preferences/ -DskipTests &> /dev/null || { echo "Error building preferences"; exit 1; }
echo "Building recommendations with Maven"
mvn package -f /root/istio-tutorial/recommendations/ -DskipTests &> /dev/null || { echo "Error building recommendations"; exit 1; }

#Docker build
echo "Building customer with Docker. First Docker build takes a while"
docker build -t example/customer /root/istio-tutorial/customer/ &> /dev/null || { echo "Error building customer docker image"; exit 1; }
echo "Building preferences with Docker"
docker build -t example/preferences /root/istio-tutorial/preferences/ &> /dev/null || { echo "Error building preferences docker image"; exit 1; }
echo "Building recommendations with Docker"
docker build -t example/recommendations:v1 /root/istio-tutorial/recommendations/ &> /dev/null || { echo "Error building recommendations docker image"; exit 1; }

#Deploy to OpenShift
oc apply -f <(/root/istio-0.4.0/bin/istioctl kube-inject -f /root/istio-tutorial/customer/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/istio-0.4.0/bin/istioctl kube-inject -f /root/istio-tutorial/preferences/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/istio-0.4.0/bin/istioctl kube-inject -f /root/istio-tutorial/recommendations/src/main/kubernetes/Deployment.yml) -n tutorial

oc create -f /root/istio-tutorial/customer/src/main/kubernetes/Service.yml -n tutorial
oc create -f /root/istio-tutorial/preferences/src/main/kubernetes/Service.yml -n tutorial
oc create -f /root/istio-tutorial/recommendations/src/main/kubernetes/Service.yml -n tutorial

oc expose service customer -n tutorial
echo "All 3 microservices (customer, preferences, recommendations) have been deployed"


