Go to the source folder of `preference` microservice.

Execute: `cd ~/projects/istio-tutorial/preference/`{{execute}}

Now execute `mvn package`{{execute}} to create the `preference.jar` file.

## Create the preference docker image.

We will now use the provided [`Dockerfile`](https://github.com/redhat-developer-demos/istio-tutorial/blob/master/preference/Dockerfile) to create a docker image.

This image will be called `example/preferences`.

To build a docker image type: `docker build -t example/preference .`{{execute}}

You can check the image that was create by typing `docker images | grep preference`{{execute}}

## Injecting the sidecar proxy.

Now let's deploy the preference pod with its sidecar.

Execute: `oc apply -f <(istioctl kube-inject -f src/main/kubernetes/Deployment.yml) -n tutorial`{{execute}}

Also create a service: `oc create -f src/main/kubernetes/Service.yml`{{execute}}

To watch the creation of the pods, execute `oc get pods -w`{{execute}}

Once that the preference pod READY column is 2/2, you can hit `CTRL+C`. 

Try the microservice by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

Preferences returns a value but also an error message based on the missing recommendations service

`C100 * 503 Service Unavailable *`

This concludes the deployment of `preference` microservice.