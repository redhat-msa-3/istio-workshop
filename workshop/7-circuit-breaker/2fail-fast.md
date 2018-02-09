First, you need to insure you have a routerule in place. Let's use a 50/50 split of traffic:

Execute `oc create -f ~/projects/istio-tutorial/istiofiles/route-rule-recommendation-v1_and_v2_50_50.yml -n tutorial`{{execute}}

## Load test without circuit breaker

Let's perform a load test in our system with siege. We'll have 20 clients sending 2 concurrent requests each:

`siege -r 2 -c 20 -v http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}