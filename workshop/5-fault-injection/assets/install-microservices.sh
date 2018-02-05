#!/bin/bash
echo "Cloning project's git repository"
git --git-dir=/root/projects/istio-tutorial/.git pull || { echo "Error running git pull"; exit 1; }
cp -Rvf /root/projects/istio-tutorial/recommendations/ /root/projects/istio-tutorial/recommendations-v2 &> /dev/null
git apply /root/recommendations-v2.diff --directory=/root/projects/istio-tutorial/ || { echo "Git apply failed. Check file recommendations-v2.diff"; exit 1; }
rm /root/recommendations-v2.diff
oc new-project tutorial
oc adm policy add-scc-to-user privileged -z default -n tutorial

#Package Projects
echo "Building customer microservice with Maven. First Maven build takes a while"
mvn package -f /root/projects/istio-tutorial/customer/ -DskipTests &> /dev/null || { echo "Error building customer"; exit 1; }
echo "Building preferences microservice with Maven"
mvn package -f /root/projects/istio-tutorial/preferences/ -DskipTests &> /dev/null || { echo "Error building preferences"; exit 1; }
echo "Building recommendations microservice with Maven"
mvn package -f /root/projects/istio-tutorial/recommendations/ -DskipTests &> /dev/null || { echo "Error building recommendations"; exit 1; }
echo "Building recommendations-v2 microservice with Maven"
mvn package -f /root/projects/istio-tutorial/recommendations-v2/ -DskipTests &> /dev/null || { echo "Error building recommendations-v2"; exit 1; }

#docker build
echo "Building customer docker image. First docker build takes a while"
docker build -t example/customer /root/projects/istio-tutorial/customer/ &> /dev/null || { echo "Error building customer docker image"; exit 1; }
echo "Building preferences docker image"
docker build -t example/preferences /root/projects/istio-tutorial/preferences/ &> /dev/null || { echo "Error building preferences docker image"; exit 1; }
echo "Building recommendations docker image"
docker build -t example/recommendations:v1 /root/projects/istio-tutorial/recommendations/ &> /dev/null || { echo "Error building recommendations docker image"; exit 1; }
echo "Building recommendations-v2 docker image"
docker build -t example/recommendations:v2 /root/projects/istio-tutorial/recommendations-v2/ &> /dev/null || { echo "Error building recommendations-v2 docker image"; exit 1; }

#Deploy to OpenShift
oc apply -f <(/root/installation/istio-0.5.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/customer/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/installation/istio-0.5.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/preferences/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/installation/istio-0.5.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/recommendations/src/main/kubernetes/Deployment.yml) -n tutorial
oc apply -f <(/root/installation/istio-0.5.0/bin/istioctl kube-inject -f /root/projects/istio-tutorial/kubernetesfiles/recommendations_v2_deployment.yml) -n tutorial

oc create -f /root/projects/istio-tutorial/customer/src/main/kubernetes/Service.yml -n tutorial
oc create -f /root/projects/istio-tutorial/preferences/src/main/kubernetes/Service.yml -n tutorial
oc create -f /root/projects/istio-tutorial/recommendations/src/main/kubernetes/Service.yml -n tutorial

oc expose service customer -n tutorial
echo "All 4 microservices (customer, preferences, recommendations-v1 and recommendations-v2) have been deployed"

