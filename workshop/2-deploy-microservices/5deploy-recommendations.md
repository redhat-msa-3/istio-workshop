Go to the source folder of `recommendations` microservice.

Execute: `cd ~/istio-tutorial/recommendations/`{{execute}}

Now execute `mvn package`{{execute}} to create the `recommendations-0.0.1-SNAPSHOT.jar` file.

## Create the recommendations docker image.

We will now use the provided [`Dockerfile`](https://github.com/redhat-developer-demos/istio-tutorial/blob/master/recommendations/Dockerfile) to create a docker image.

This image will be called `example/recommendations:v1`.

**Note:** The tag "v1" at the end of the image name is important. We will be creating a v2 version of recommendations later in this tutorial. Having both a v1 and v2 version of the recommendations code will allow us to exercise some interesting aspects of Istio's capabilities.

To build a docker image type: `docker build -t example/recommendations:v1 .`{{execute}}

You can check the image that was create by typing `docker images | grep recommendations`{{execute}}

## Injecting the sidecar proxy.

Now let's deploy the recommendations pod with its sidecar.

Execute: `oc apply -f <(istioctl kube-inject -f src/main/kubernetes/Deployment.yml) -n tutorial`{{execute}}

Also create a service: `oc create -f src/main/kubernetes/Service.yml`{{execute}}

To watch the creation of the pods, execute `oc get pods -w`{{execute}}

Once that the preference pod READY column is 2/2, you can hit `CTRL+C`. 

Try the microservice by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

It returns:

`C100 *{"P1":"Red", "P2":"Big"} && Clifford v1 1 {hostname} 1*`

This concludes the deployment of `recommendations` microservice.
