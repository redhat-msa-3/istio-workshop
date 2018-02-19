Instead of failing immediately, retry the Service N more times

We will use Istio and return 503's about 50% of the time. Send `all users` to `v2`which will throw out some `503`'s.

`oc create -f ~/projects/istio-tutorial/istiofiles/route-rule-recommendation-v2_503.yml -n tutorial`{{execute T1}}

Now, if you hit the customer endpoint several times, you should see some 503's

To check this behaviour, send several requests to the microservices on `Terminal 2` to see their responses
`while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .5; done`{{execute T2 interrupt}}

Now check the file `/istiofiles/route-rule-recommendation-v2_retry.yml`{{open}}.

Note that this `RouteRule` provides `simpleRetry` that perform `3 attemps` on `recommendation` with a label `version=v2`, using a timeout of `2 seconds per try`.

Let's apply this rule: `oc create -f ~/projects/istio-tutorial/istiofiles/route-rule-recommendation-v2_retry.yml -n tutorial`{{execute T1}}

and after a few seconds, things will settle down and you will see it work every time.

To check this behaviour, send several requests to the microservices on `Terminal 2` to see their responses
`while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .5; done`{{execute T2}}

You can see the active RouteRules via `oc get routerules -n tutorial`{{execute T1}}

Now, delete the retry rule and see the old behavior, some random 503s

`oc delete routerule recommendation-v2-retry -n tutorial`{{execute T1}}

To check the old 503 error behaviour, send several requests to the microservices on `Terminal 2` to see their responses
`while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .5; done`{{execute T2}}


Hit CTRL+C when you are satisfied.

Now, delete the 503 rule.

`oc delete routerule recommendation-v2-503 -n tutorial`{{execute T1}}

To check if you have random load-balance without any `503` errors, try the microservice on `Terminal 2`: `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .5; done`{{execute T2}}
