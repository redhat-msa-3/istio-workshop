We can experiment with Istio routing rules by making a change to RecommendationsController.java.

Open `RecommendationsController.java` in the editor, and make the following modifications.

**Note**: The file shold appear in the file explorer in some seconds.

<pre class="file" data-filename="/root/istio-tutorial/recommendations/src/main/java/com/example/recommendations/RecommendationsController.java">
    System.out.println("Big Red Dog v2 " + cnt);
     
    return "Clifford v2 " + cnt;
</pre>

**Note**: The file is saved automatically.

Now go to the recommendations folder `cd ~/istio-tutorial/recommendations/`{{execute}}

Compile the project with the modifications that you did.

`mvn package`{{execute}}

## Create the recommendations:v2 docker image.

We will now create a new image using `v2`. The `v2`tag during the docker build is significant.

Execute `docker build -t example/recommendations:v2 .`{{execute}}

You can check the image that was create by typing `docker images | grep recommendations`{{execute}}

## Create a second deployment with sidecar proxy

There is also a 2nd deployment.yml file to label things correctly

Execute: `oc apply -f <(istioctl kube-inject -f ../kubernetesfiles/recommendations_v2_deployment.yml) -n tutorial`{{execute}}

To watch the creation of the pods, execute `oc get pods -w`{{execute}}

Once that the recommendations pod READY column is 2/2, you can hit `CTRL+C`. 

Try the microservice by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

You likely see "Clifford v1 5", where the 5 is basically the number of times you hit the endpoint.

Try again the microservice by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

you likely see "Clifford v2 1" as by default you get random load-balancing when there is more than one Pod behind a Service





