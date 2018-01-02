ssh root@host01 "oc adm policy add-cluster-role-to-user admin developer"
ssh root@host01 "oc login -u system:admin'"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z istio-egress-service-account -n istio-system"
ssh root@host01 "oc adm policy add-scc-to-user anyuid -z default -n istio-system"
ssh root@host01 "wget https://github.com/istio/istio/releases/download/0.4.0/istio-0.4.0-linux.tar.gz -P /root/"
ssh root@host01 "tar -zxvf istio-0.4.0-linux.tar.gz"

