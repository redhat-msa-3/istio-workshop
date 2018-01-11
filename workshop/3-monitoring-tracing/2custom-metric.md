Istio also allows you to specify custom metrics which can be seen inside of the Prometheus dashboard

Look at the file https://github.com/redhat-developer-demos/istio_tutorial/blob/master/istiofiles/recommendations_requestcount.yml

It specifies an istio rule that invokes the `recommendationsrequestcounthandler` for every invocation to `recommendations.springistio.svc.cluster.local`

**TODO** Needs more exaplanation about this file

Go to the `istio_tutorial` folder. `cd ~/istio_tutorial`{{execute}}

Now, add the custom metric and rule.

Execute `oc apply -f istiofiles/recommendations_requestcount.yml -n istio-system`{{execute}}

Run several requests through the system: `curl http://customer-springistio.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

Open the Prometheus Dashboard at http://prometheus-istio-system.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com and add the following metric

`round(increase(istio_recommendations_request_count{destination="recommendations.springistio.svc.cluster.local" }[1m]))`

and select `Execute`.

![](../../assets/monitoring/prometheus_custom_metric.png)

Make sure to have the `Graph` tab selected.