Go to the source folder of `preferences` microservice.

Execute: `cd ~/istio-tutorial/preferences/`{{execute}}

Now execute `mvn package`{{execute}} to create the `preferences-0.0.1-SNAPSHOT.jar` file.

## Create the preferences docker image.

We will now use the provided [`Dockerfile`](https://github.com/redhat-developer-demos/istio-tutorial/blob/master/preferences/Dockerfile) to create a docker image.

This image will be called `example/preferences`.

To build a docker image type: `docker build -t example/preferences .`{{execute}}

You can check the image that was create by typing `docker images | grep preferences`{{execute}}

## Injecting the sidecar proxy.

Now let's deploy the preferences pod with its sidecar.

Execute: `oc apply -f <(istioctl kube-inject -f src/main/kubernetes/Deployment.yml) -n tutorial`{{execute}}

Also create a service: `oc create -f src/main/kubernetes/Service.yml`{{execute}}

To watch the creation of the pods, execute `oc get pods -w`{{execute}}

Once that the preference pod READY column is 2/2,, you can hit `CTRL+C`. 

Try the microservice by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

Preferences returns a value but also an error message based on the missing recommendations service

`C100 *{"P1":"Red", "P2":"Big"} && I/O error on GET request for "http://recommendations:8080/"`

This concludes the deployment of `preferences` microservice.
