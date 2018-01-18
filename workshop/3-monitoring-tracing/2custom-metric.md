Istio also allows you to specify custom metrics which can be seen inside of the Prometheus dashboard

Look at the file https://github.com/redhat-developer-demos/istio-tutorial/blob/master/istiofiles/recommendations_requestcount.yml

It specifies an istio rule that invokes the `recommendationsrequestcounthandler` for every invocation to `recommendations.tutorial.svc.cluster.local`

**TODO** Needs more exaplanation about this file

Go to the `istio-tutorial` folder. `cd ~/istio-tutorial`{{execute}}

Now, add the custom metric and rule.

Execute `oc apply -f istiofiles/recommendations_requestcount.yml -n istio-system`{{execute}}

Run several requests through the system: `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

Check `Prometheus` route by typing `oc get routes -n istio-system`{{execute}}

Now that you know the URL of `Prometheus`, access it at  

http://prometheus-istio-system.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/graph?g0.range_input=1m&g0.stacked=1&g0.expr=&g0.tab=0 

and add the following metric

`round(increase(istio_recommendations_request_count{destination="recommendations.tutorial.svc.cluster.local" }[60m]))`

and select `Execute`.

![](../../assets/monitoring/prometheus_custom_metric.png)

Run more requests through the system: `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}} and hit `Execute` again in the Prometheus Dashboard
