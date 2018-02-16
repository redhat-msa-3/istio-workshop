For monitoring, Istio offers out of the box monitoring via Prometheus and Grafana.

## Install Prometheus and Grafana

To make it work, we need first to install [`Prometheus`](https://prometheus.io/) and [`Grafana`](https://grafana.com/). 

Let's go to the istio installation folder.

Execute `cd ~/installation/istio-0.5.0/`{{execute}}

Now we need to apply the following files to the OpenShift instance:

`oc apply -f install/kubernetes/addons/prometheus.yaml -n istio-system`{{execute}}

`oc apply -f install/kubernetes/addons/grafana.yaml -n istio-system`{{execute}}

After the installation of these Istio add-ons, we need to expose the services.

Execute: `oc expose svc prometheus -n istio-system`{{execute}}

and 

`oc expose svc grafana -n istio-system`{{execute}}

Now, let's wait until `grafana` pod is up and running.

Execute `oc get pods -w -n istio-system`{{execute}} and wait until `grafana` pod STATUS is `Running`.

Once it's Running, click `CTRL+C` and access Grafana console.

Check `Grafana` route by typing `oc get routes -n istio-system`{{execute}}

Now that you know the URL of `Grafana`, access it at  http://grafana-istio-system.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com

At Grafana console, select the Istio Dashboard.

![](../../assets/monitoring/grafana.png)

## Try Grafana console

Now let's wait also for the microservices to get deployed.

Execute: `oc get pods -w -n tutorial`{{execute}}.

Wait until all microservices READY column show 2/2. Then click `CTRL+C` and perform some calls to the `customer` microservice.

Try the microservice several times by typing: `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute T1}}

Return to http://grafana-istio-system.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com and refresh the screen.

Note that you can now visualize request information for each microservice

![](../../assets/monitoring/grafana-services.png)

