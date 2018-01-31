#!/bin/bash
echo "Cloning project's git repository"
git clone https://github.com/redhat-developer-demos/istio-tutorial /root/projects/istio-tutorial &> /dev/null || { echo "Error cloning repository"; exit 1; }
oc new-project tutorial
oc adm policy add-scc-to-user privileged -z default -n tutorial

#Package Projects
echo "Building customer microservice with Maven. First Maven build takes a while"
mvn package -f /root/projects/istio-tutorial/customer/ -DskipTests &> /dev/null || { echo "Error building customer"; exit 1; }
echo "Building preferences microservice with Maven"
mvn package -f /root/projects/istio-tutorial/preferences/ -DskipTests &> /dev/null || { echo "Error building preferences"; exit 1; }
echo "Building recommendations microservice with Maven"
mvn package -f /root/projects/istio-tutorial/recommendations/ -DskipTests &> /dev/null || { echo "Error building recommendations"; exit 1; }

#docker build
echo "Building customer docker image. First docker build takes a while"
docker build -t example/customer /root/projects/istio-tutorial/customer/ &> /dev/null || { echo "Error building customer docker image"; exit 1; }
echo "Building preferences docker image"
docker build -t example/preferences /root/projects/istio-tutorial/preferences/ &> /dev/null || { echo "Error building preferences docker image"; exit 1; }
echo "Building recommendations docker image"
docker build -t example/recommendations:v1 /root/projects/istio-tutorial/recommendations/ &> /dev/null || { echo "Error building recommendations docker image"; exit 1; }

#Deploy to OpenShift
oc apply -f <(/root/installation/istio-0.4.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/customer/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/installation/istio-0.4.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/preferences/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/installation/istio-0.4.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/recommendations/src/main/kubernetes/Deployment.yml) -n tutorial

oc create -f /root/projects/istio-tutorial/customer/src/main/kubernetes/Service.yml -n tutorial
oc create -f /root/projects/istio-tutorial/preferences/src/main/kubernetes/Service.yml -n tutorial
oc create -f /root/projects/istio-tutorial/recommendations/src/main/kubernetes/Service.yml -n tutorial

oc expose service customer -n tutorial
echo "All 3 microservices (customer, preferences, recommendations) have been deployed"


