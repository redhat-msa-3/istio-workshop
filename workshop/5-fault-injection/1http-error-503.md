By default, recommendation v1 and v2 are being randomly load-balanced as that is the default behavior in Kubernetes/OpenShift

If you look for all recommendations pods that contains the label `app=recommendation`, you will find `v1` and `v2`.

Try: `oc get pods -l app=recommendation -n tutorial`{{execute}}

To check this behaviour, try the microservice several times by typing `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute}}

Hit CTRL+C when you are satisfied.

Now check the file `/istiofiles/route-rule-recommendation-503.yml`{{open}}.

Note that this `RouteRule` provides `httpFault` that will `abort` the request `50% of the time` with a `httpStatus=503`.

Let's apply this rule: `oc create -f ~/projects/istio-tutorial/istiofiles/route-rule-recommendation-503.yml -n tutorial`{{execute}}

To check the new behaviour, try the microservice several times by typing `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute}}

Hit CTRL+C when you are satisfied.

## Cleanup

To remove the HTTP Error 503 behaviour, simply delete this `routerule` by executing `oc delete routerule recommendation-503 -n tutorial`{{execute}}

To check if you have random load-balance, try the microservice several times by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

