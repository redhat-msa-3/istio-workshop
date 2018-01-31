Wait only N seconds before giving up and failing. At this point, no other route rules should be in effect. Perform and 
`oc get routerules`{{execute}} and maybe and `oc delete routerule {rulename}`{{execute}} if there are some.

First, introduce some wait time in recommendations v2 by uncommenting the line 37 that call the timeout method. Update RecommendationsController.java making it a slow perfomer

<pre>
      @RequestMapping("/")
      public ResponseEntity<String> getRecommendations() {
          count++;
          logger.debug(String.format("Big Red Dog v1 %s %d", HOSTNAME, count));

          timeout();

          logger.debug("recommendations ready to return");
          if (misbehave) {
              return doMisbehavior();
          }
          return ResponseEntity.ok(String.format("Clifford v1 %s %d", HOSTNAME, count));
      }
</pre>

**Note:** The file is saved automatically.

Rebuild and redeploy the recommendation microservices.

Go to the recommendations folder `cd ~/projects/istio-tutorial/recommendations/`{{execute}}

Compile the project with the modifications that you did.

`mvn package`{{execute}}

Execute `docker build -t example/recommendations:v2 .`{{execute}}

You can check the image that was create by typing `docker images | grep recommendations`{{execute}}

Now let's delete the previous v2 pod to force the creation of a new pod using the new image.

`oc delete pod -l app=recommendations,version=v2 -n tutorial`{{execute}}

## Timeout rule

Check the file [route-rule-recommendations-timeout.yml](https://github.com/redhat-developer-demos/istio-tutorial/blob/master/istiofiles/route-rule-recommendations-timeout.yml).

Note that this `RouteRule` provides a `simpleTimeout` of `1 second`.

Let's apply this rule: `oc create -f ~/projects/istio-tutorial/istiofiles/route-rule-recommendations-timeout.yml -n tutorial`{{execute}}

You will see it return v1 OR 504 after waiting about 1 second.

To check the new behaviour, try the microservice several times by typing `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute}}

Hit CTRL+C when you are satisfied.

## Cleanup

To remove the Timeout behaviour, simply delete this `routerule` by executing `oc delete routerule recommendations-timeout -n tutorial`{{execute}}

To check if you have random load-balance, try the microservice several times by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

