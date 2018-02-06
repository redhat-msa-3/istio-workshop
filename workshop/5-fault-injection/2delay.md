The most insidious of possible distributed computing faults is not a "down" service but a service that is responding slowly, potentially causing a cascading failure in your network of services.

Now check the file `/istio-tutorial/istiofiles/route-rule-recommendation-delay.yml`{{open}}.`.

Note that this `RouteRule` provides `httpFault` that will `delay` the request `50% of the time` with a `fixedDelay=7s`.

Let's apply this rule: `oc create -f ~/projects/istio-tutorial/istiofiles/route-rule-recommendation-delay.yml -n tutorial`{{execute}}

To check the new behaviour, try the microservice several times by typing `while true; do time curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute}}

Hit CTRL+C when you are satisfied.

You will notice many requets to the customer endpoint now have a delay.

## Cleanup

To remove the delay behaviour, simply delete this `routerule` by executing `oc delete routerule recommendation-delay -n tutorial`{{execute}}

To check if you have random load-balance, try the microservice several times by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}
