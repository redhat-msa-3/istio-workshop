ssh root@host01 "oc adm policy add-cluster-role-to-user admin developer "
ssh root@host01 "oc login -u system:admin"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z istio-egress-service-account -n istio-system"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z default -n istio-system"
ssh root@host01 "wget https://github.com/istio/istio/releases/download/0.4.0/istio-0.4.0-linux.tar.gz -P /usr/src/"

ssh root@host01 "tar -zxvf /usr/src/istio-0.4.0-linux.tar.gz"

oc apply -f install/kubernetes/istio.yaml
oc apply -f install/kubernetes/addons/prometheus.yaml
oc apply -f install/kubernetes/addons/grafana.yaml
oc apply -f install/kubernetes/addons/servicegraph.yaml

oc project istio-system 

oc expose svc istio-ingress 
oc expose svc servicegraph
oc expose svc grafana
oc expose svc prometheus

oc process -f https://raw.githubusercontent.com/jaegertracing/jaeger-openshift/master/all-in-one/jaeger-all-in-one-template.yml | oc create -f -

echo "Istio installed"