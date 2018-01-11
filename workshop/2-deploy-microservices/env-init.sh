ssh root@host01 "yum install java-1.8.0-openjdk-devel tree -y"
ssh root@host01 "tar xzf /usr/src/apache-maven-3.3.9-bin.tar.gz -C /usr/src"
ssh root@host01 "rm -rf /usr/src/apache-maven-3.3.9-bin.tar.gz"
ssh root@host01 "mkdir /usr/local/maven"
ssh root@host01 "mv /usr/src/apache-maven-3.3.9/ /usr/local/maven/"
ssh root@host01 "alternatives --install /usr/bin/mvn mvn /usr/local/maven/apache-maven-3.3.9/bin/mvn 1"

ssh root@host01 "oc login -u system:admin"
ssh root@host01 "oc adm policy add-cluster-role-to-user cluster-admin developer"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z istio-egress-service-account -n istio-system"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z default -n istio-system"

ssh root@host01 "tar -zxvf /root/istio-0.4.0-linux.tar.gz -C /root" 

ssh root@host01 "oc apply -f /root/istio-0.4.0/install/kubernetes/istio.yaml"

ssh root@host01 "oc project istio-system"

ssh root@host01 "oc expose svc istio-ingress"
ssh root@host01 "oc login -u developer -p developer"
ssh root@host01 "oc project default"

