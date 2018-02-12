You should have 2 pods for recommendation based on the command bellow:

`oc get pods -l app=recommendation -n tutorial`{{execute}}

Check the file `istiofiles/route-rule-recommendation-v1-mirror-v2.yml`{{open}}

Let's apply this rule: `oc create -f ~/projects/istio-tutorial/istiofiles/route-rule-recommendation-v1-mirror-v2.yml -n tutorial`{{execute}}

Access the microservice by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

Check the logs of `recommendation:v2` to make sure that it received the request although we saw only `v1` response.

`oc logs -f `oc get pods|grep recommendation-v2|awk '{ print $1 }'` -c recommendation`

## Clean up

Delete the mirror rule:

`oc delete routerule recommendation-mirror -n tutorial`{{execute}}