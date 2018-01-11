For monitoring, Istio offers out of the box monitoring via Prometheus and Grafana.

To make it work, we need first to install [`Prometheus`](https://prometheus.io/) and [`Grafana`](https://grafana.com/). 

Let's go to the istio installation folder.

Execute `cd ~/istio-0.4.0/`{{execute}}

Now we need to apply the following file to the OpenShift instance:

`oc apply -f install/kubernetes/addons/prometheus.yaml -n istio-system`{{execute}}

`oc apply -f install/kubernetes/addons/grafana.yaml -n istio-system`{{execute}}

After the installation of these Istio add-ons, we need to expose the services.

Execute: `oc expose svc grafana -n istio-system`{{execute}}

Now, let's wait until `grafana` pod is up and running.

Execute `oc get pods -w -n istio-system`{{execute}} and wait until grafana pod STATUS is `Running`.

Once it's running, access Grafana console that is running at [http://grafana-istio-system.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com](http://grafana-istio-system.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com)

At Grafana console, select the Istio Dashboard.

![](../../assets/monitoring/grafana.png)

Now let's perform some calls to the `customer` microservice.

Execute: `curl http://customer-springistio.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}