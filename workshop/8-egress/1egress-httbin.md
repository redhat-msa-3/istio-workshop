There are two examples of egress routing, one for httpbin.org and one for github. Egress routes allow you to apply rules to how internal services interact with external APIs/services.

Create a namespace/project to hold these egress examples

`oc new-project istioegress`{{execute}}

Don't foget to add the `privileged` SCC to this project.

`oc adm policy add-scc-to-user privileged -z default -n istioegress`{{execute}}

## Create HTTPBin Java App

Go to the source folder of `egresshttpbin` microservice.

Execute: `cd ~/projects/istio-tutorial/egress/egresshttpbin/`{{execute}}

Now execute `mvn package`{{execute}} to create the fat jar.

## Create the egresshttpbin docker image.

We will now use the provided `/egress/egresshttpbin/Dockerfile`{{open}} to create a docker image.

This image will be called `example/egresshttpbin:v1`.

To build a docker image type: `docker build -t example/egresshttpbin:v1 .`{{execute}}

You can check the image that was create by typing `docker images | grep egress`{{execute}}


## Deploying the project in OpenShift

Now let's deploy this project.

Execute: `oc apply -f <(istioctl kube-inject -f src/main/kubernetes/Deployment.yml) -n istioegress`{{execute}}

Also create a service: `oc create -f src/main/kubernetes/Service.yml`{{execute}} 

Let's add an OpenShift Route that exposes that endpoint.

Execute: `oc expose service egresshttpbin`{{execute}}.

Check the route: `oc get route`{{execute}}

To watch the creation of the pods, execute `oc get pods -w`{{execute}}

Once that the customer pod READY column is 2/2, you can hit `CTRL+C`. 

Try the microservice by typing `curl http://egresshttpbin-istioegress.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

**Note:** It does not work...yet, more to come.
