Instead of failing immediately, retry the Service N more times

We will use Istio and return 503's about 50% of the time. Send all users to v2 which will throw out some 503's.

`oc create -f istio-tutorial/istiofiles/route-rule-recommendations-v2_503.yml -n tutorial`{{execute}}

Now, if you hit the customer endpoint several times, you should see some 503's

`while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute}}

Hit CTRL+C when you are satisfied.

Now check the file [route-rule-recommendations-v2_retry.yml](https://github.com/redhat-developer-demos/istio-tutorial/blob/master/istiofiles/route-rule-recommendations-v2_retry.yml).

Note that this `RouteRule` provides `simpleRetry` that perform `3 attemps` with a timeout of `2 seconds per try`.

Let's apply this rule: `oc create -f istio-tutorial/istiofiles/route-rule-recommendations-v2_retry.yml -n tutorial`{{execute}}

and after a few seconds, things will settle down and you will see it work every time.

To check the new behaviour, try the microservice several times by typing `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute}}

You can see the active RouteRules via `oc get routerules -n tutorial`{{execute}}

Now, delete the retry rule and see the old behavior, some random 503s

`oc delete routerule recommendations-v2-retry -n tutorial`{{execute}}

To check the old 503 error behaviour, try the microservice several times by typing `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute}}

Hit CTRL+C when you are satisfied.

Now, delete the 503 rule and back to random load-balancing between v1 and v2

`oc delete routerule recommendations-v2-503 -n tutorial`{{execute}}

To check if you have random load-balance, try the microservice several times by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}




