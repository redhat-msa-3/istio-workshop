The most insidious of possible distributed computing faults is not a "down" service but a service that is responding slowly, potentially causing a cascading failure in your network of services.

Now check the file [route-rule-recommendations-delay.yml](https://github.com/redhat-developer-demos/istio-tutorial/blob/master/istiofiles/route-rule-recommendations-delay.yml).

Note that this `RouteRule` provides `httpFault` that will `delay` the request `50% of the time` with a `fixedDelay=7s`.

Let's apply this rule: `oc create -f istio-tutorial/istiofiles/route-rule-recommendations-delay.yml -n tutorial`{{execute}}

To check the new behaviour, try the microservice several times by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

You will notice many requets to the customer endpoint now have a delay. If you are monitoring the logs for recommendations v1 and v2, you will also see the delay happens BEFORE the recommendations service is actually called



