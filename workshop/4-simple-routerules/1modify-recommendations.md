We can experiment with Istio routing rules by making a change to RecommendationsController.java.

Open `RecommendationsController.java` in the editor, and make the following modifications.

**Note**: The file shold appear in the file explorer in some seconds.

<pre>
    logger.debug(String.format("Big Red Dog v2 %s %d", HOSTNAME, count));
     
    return ResponseEntity.ok(String.format("Clifford v2 %s %d", HOSTNAME, count));
</pre>

**Note:** The file is saved automatically.

Now go to the recommendations folder `cd ~/istio-tutorial/recommendations/`{{execute}}

Compile the project with the modifications that you did.

`mvn package`{{execute}}

**NOTE:** If you see the following message *-bash: mvn: command not found*, wait a little bit and try again. This happens because `Maven` still being prepared in your environment in the background.

## Create the recommendations:v2 docker image.

We will now create a new image using `v2`. The `v2`tag during the docker build is significant.

Execute `docker build -t example/recommendations:v2 .`{{execute}}

You can check the image that was create by typing `docker images | grep recommendations`{{execute}}

## Create a second deployment with sidecar proxy

There is also a 2nd deployment.yml file to label things correctly

Execute: `oc apply -f <(istioctl kube-inject -f ../kubernetesfiles/recommendations_v2_deployment.yml) -n tutorial`{{execute}}

To watch the creation of the pods, execute `oc get pods -w`{{execute}}

Once that the recommendations pod READY column is 2/2, you can hit `CTRL+C`. 

Test the `customer` endpoint: `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

You likely see "Clifford v2 {hostname} 1" as by default you get random load-balancing when there is more than one Pod behind a Service.

You likely see "Clifford v1 {hostname} 5", where the 5 is basically the number of times you hit the endpoint.

Send several requests to see their responses

`while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; echo; sleep .1; done`{{execute}}

Hit CTRL+C when you are satisfied.

The default Kubernetes/OpenShift behavior is to round-robin load-balance across all available pods behind a single Service. Add another replica of recommendations-v2 Deployment.

`oc scale --replicas=2 deployment/recommendations-v2`{{execute}}

Now, you will see two requests into the v2 and one for v1.

`while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; echo; sleep .1; done`{{execute}}

Hit CTRL+C when you are satisfied.

Scale back to a single replica of the recommendations-v2 Deployment

`oc scale --replicas=1 deployment/recommendations-v2`{{execute}}

