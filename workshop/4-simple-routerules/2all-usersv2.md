Check the file https://github.com/redhat-developer-demos/istio-tutorial/blob/master/istiofiles/route-rule-recommendations-v2.yml.

Note that the `RouteRule` specifies that the destination will be the recommendation that contains the label `version=v2`.

Let's apply this file.

`oc create -f ~/istio-tutorial/istiofiles/route-rule-recommendations-v2.yml -n tutorial`{{execute}}

Try the microservice several times by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

you should only see v2 being returned.