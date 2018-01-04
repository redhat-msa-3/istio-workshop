Go to the source folder of `customer` microservice.

Execute: `cd ~/istio_tutorial/preferences/`{{execute}}

Now execute `mvn package`{{execute}} to create the `preferences-0.0.1-SNAPSHOT.jar` file.

## Create the preferences docker image.

We will now use the provided [`Dockerfile`](https://github.com/redhat-developer-demos/istio_tutorial/blob/master/preferences/Dockerfile) to create a docker image.

This image will be called `preferences/customer`.

To build a docker image type: `docker build -t preferences/customer .`{{execute}}

You can check the image that was create by typing `docker images | grep preferences`{{execute}}

## Injecting the sidecar proxy.

Now let's deploy the preferences pod with its sidecar.

Execute: `oc apply -f <(istioctl kube-inject -f src/main/kubernetes/Deployment.yml) -n springistio`{{execute}}

Also create a service: `oc create -f src/main/kubernetes/Service.yml`{{execute}} 

This concludes the deployment of `preferences` microservice.
