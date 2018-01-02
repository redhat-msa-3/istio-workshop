oc login -u system:admin
oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-egress-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z default -n istio-system
wget https://github.com/istio/istio/releases/download/0.3.0/istio-0.3.0-linux.tar.gz
tar -zxvf istio-0.3.0-linux.tar.gz
oc  apply -f ~/istio-0.3.0/install/kubernetes/istio.yaml
