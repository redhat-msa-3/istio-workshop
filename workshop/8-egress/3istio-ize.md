Open the file `istiofiles/egress_httpbin.yml`{{open}}.

Let's apply this file.

`oc create -f ~/projects/istio-tutorial/istiofiles/egress_httpbin.yml -n tutorial`{{execute}}

`istioctl get egressrules`{{execute}}

Try the microservice by typing `curl http://egresshttpbin-istioegress.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

