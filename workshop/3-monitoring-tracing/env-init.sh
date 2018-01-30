ssh root@host02 "rm -rf /root/projects/ /root/temp-pom.xml"

ssh root@host02 "oc login -u system:admin"
ssh root@host02 "oc adm policy add-cluster-role-to-user cluster-admin developer"
ssh root@host02 "oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system"
ssh root@host02 "oc adm policy add-scc-to-user anyuid -z istio-egress-service-account -n istio-system"
ssh root@host02 "oc adm policy add-scc-to-user anyuid -z default -n istio-system"

ssh root@host02 "wget https://github.com/istio/istio/releases/download/0.4.0/istio-0.4.0-linux.tar.gz -P /root/"
ssh root@host02 "tar -zxvf /root/istio-0.4.0-linux.tar.gz -C /root" 

ssh root@host02 "oc apply -f /root/istio-0.4.0/install/kubernetes/istio.yaml"

ssh root@host02 "oc expose svc istio-ingress -n istio-system"
ssh root@host02 "oc login -u developer -p developer"

ssh root@host02 "oc new-project tutorial"
ssh root@host02 "oc adm policy add-scc-to-user privileged -z default -n tutorial"
ssh root@host02 "git clone https://github.com/redhat-developer-demos/istio-tutorial /root/istio-tutorial"

ssh root@host02 "mvn package -f /root/istio-tutorial/customer/ -DskipTests"
ssh root@host02 "mvn package -f /root/istio-tutorial/recommendations/ -DskipTests"
ssh root@host02 "mvn package -f /root/istio-tutorial/preferences/ -DskipTests"

ssh root@host02 "docker build -q -t example/customer /root/istio-tutorial/customer/"
ssh root@host02 "docker build -q -t example/preferences /root/istio-tutorial/preferences/"
ssh root@host02 "docker build -q -t example/recommendations:v1 /root/istio-tutorial/recommendations/"

ssh root@host02 "oc apply -f <(/root/istio-0.4.0/bin/istioctl kube-inject -f /root/istio-tutorial/customer/src/main/kubernetes/Deployment.yml) -n tutorial"
ssh root@host02 "oc apply -f <(/root/istio-0.4.0/bin/istioctl kube-inject -f /root/istio-tutorial/preferences/src/main/kubernetes/Deployment.yml) -n tutorial"
ssh root@host02 "oc apply -f <(/root/istio-0.4.0/bin/istioctl kube-inject -f /root/istio-tutorial/recommendations/src/main/kubernetes/Deployment.yml) -n tutorial"

ssh root@host02 "oc create -f /root/istio-tutorial/customer/src/main/kubernetes/Service.yml"
ssh root@host02 "oc create -f /root/istio-tutorial/preferences/src/main/kubernetes/Service.yml"
ssh root@host02 "oc create -f /root/istio-tutorial/recommendations/src/main/kubernetes/Service.yml"

ssh root@host02 "oc expose service customer -n tutorial"

