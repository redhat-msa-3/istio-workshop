oc adm policy add-cluster-role-to-user admin developer > /dev/null 2>&1
oc login -u system:admin > /dev/null 2>&1
oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system > /dev/null 2>&1
oc adm policy add-scc-to-user anyuid -z istio-egress-service-account -n istio-system > /dev/null 2>&1
oc adm policy add-scc-to-user anyuid -z default -n istio-system > /dev/null 2>&1
wget https://github.com/istio/istio/releases/download/0.4.0/istio-0.4.0-linux.tar.gz -P /root/ > /dev/null 2>&1
cd /root/ > /dev/null 2>&1
tar -zxvf istio-0.4.0-linux.tar.gz > /dev/null 2>&1
cd /root/istio-0.4.0/ > /dev/null 2>&1
oc apply -f install/kubernetes/istio.yaml > /dev/null 2>&1
oc apply -f install/kubernetes/addons/prometheus.yaml > /dev/null 2>&1
oc apply -f install/kubernetes/addons/grafana.yaml > /dev/null 2>&1
oc apply -f install/kubernetes/addons/servicegraph.yaml > /dev/null 2>&1

oc project istio-system  > /dev/null 2>&1

oc expose svc istio-ingress  > /dev/null 2>&1
oc expose svc servicegraph > /dev/null 2>&1
oc expose svc grafana > /dev/null 2>&1
oc expose svc prometheus > /dev/null 2>&1

oc process -f https://raw.githubusercontent.com/jaegertracing/jaeger-openshift/master/all-in-one/jaeger-all-in-one-template.yml | oc create -f -  > /dev/null 2>&1
cd /root/
echo "Istio installed"