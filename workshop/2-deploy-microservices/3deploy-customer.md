Go to the source folder of `customer` microservice.

Execute: `cd ~/projects/istio-tutorial/customer/`{{execute}}

Now execute `mvn package`{{execute}} to create the `customer.jar` file.

## Create the customer docker image.

We will now use the provided [`Dockerfile`](https://github.com/redhat-developer-demos/istio-tutorial/blob/master/customer/Dockerfile) to create a docker image.

`Dockerfile`{{open}}

This image will be called `example/customer`.

To build a docker image type: `docker build -t example/customer .`{{execute}}

You can check the image that was create by typing `docker images | grep customer`{{execute}}

## Injecting the sidecar proxy.

Currently using the "manual" way of injecting the Envoy sidecar.

Check the version of `istioctl`. Execute `istioctl version`{{execute}}.

Also, make sure that you are using `tutorial` project. Execute `oc project tutorial`{{execute}}

Now let's deploy the customer pod with its sidecar.

Execute: `oc apply -f <(istioctl kube-inject -f src/main/kubernetes/Deployment.yml) -n tutorial`{{execute}}

Also create a service: `oc create -f src/main/kubernetes/Service.yml`{{execute}} 

Since customer is the forward most microservice (customer -> preference -> recommendation), let's add an OpenShift Route that exposes that endpoint.

Execute: `oc expose service customer`{{execute}}.

Check the route: `oc get route`{{execute}}

To watch the creation of the pods, execute `oc get pods -w`{{execute}}

Once that the customer pod READY column is 2/2, you can hit `CTRL+C`. 

Try the microservice by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

You should see the following error because `preference` is not yet deployed, so you only get a partial response of "C100" plus the error message

`customer => I/O error on GET request for "http://preference:8080": preference; nested exception is java.net.UnknownHostException: preference`

This concludes the deployment of `customer` microservice.
