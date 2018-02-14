You should have 2 pods for recommendation based on the command bellow:

`oc get pods -l app=recommendation -n tutorial`{{execute}}

Check the file `istiofiles/route-rule-recommendation-v1-mirror-v2.yml`{{open}}

Note that it routes `100%` of the requests to `v1` and `0%` to `v2`. However it also `mirror` these requests to `recommendation` with the label `version=v2`.

Let's apply this rule: `oc create -f ~/projects/istio-tutorial/istiofiles/route-rule-recommendation-v1-mirror-v2.yml -n tutorial`{{execute}}

Access the microservice several times by typing `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute}}

Note that it only replies from `v1`.

Hit CTRL+C when you are satisfied.

Check the logs of `recommendation:v2` to make sure that it received the request although we saw only `v1` response.

`oc logs -f $(oc get pods|grep recommendation-v2|awk '{ print $1 }') -c recommendation`{{execute}}

Hit CTRL+C when you are satisfied.

## Clean up

To remove the `mirror` behaviour, delete the `routerule`.

`oc delete routerule recommendation-mirror -n tutorial`{{execute}}