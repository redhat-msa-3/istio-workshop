For monitoring, Istio offers out of the box monitoring via Prometheus and Grafana.

To make it work, we need first to install [`Prometheus`](https://prometheus.io/) and [`Grafana`](https://grafana.com/). 

Let's go to the istio installation folder.

Execute `cd ~/istio-0.4.0/`{{execute}}

Now we need to apply the following file to the OpenShift instance:

`oc apply -f install/kubernetes/addons/prometheus.yaml -n istio-system`{{execute}}

`oc apply -f install/kubernetes/addons/grafana.yaml -n istio-system`{{execute}}

After the installation of these Istio add-ons, we need to expose the services.

Execute: `oc expose svc servicegraph -n istio-system`{{execute}}

and 

`oc expose svc grafana -n istio-system`{{execute}}