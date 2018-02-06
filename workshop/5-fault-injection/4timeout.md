Wait only N seconds before giving up and failing. At this point, no other route rules should be in effect. Perform and 
`oc get routerules`{{execute}} and maybe and `oc delete routerule {rulename}`{{execute}} if there are some.

First, introduce some wait time in recommendations v2 by uncommenting the line 39 that call the timeout method. This method, will cause a wait time of 3 seconds. Update `/recommendation-v2/src/main/java/com/redhat/developer/demos/recommendation/RecommendationController.java`{{open}} making it a slow perfomer. 

```java
      @RequestMapping("/")
      public ResponseEntity<String> getRecommendations() {
          count++;
          logger.debug(String.format("recommendation request from %s: %d", HOSTNAME, count));

          timeout();

          logger.debug("recommendation service ready to return");
          if (misbehave) {
              return doMisbehavior();
          }
          return ResponseEntity.ok(String.format(RecommendationController.RESPONSE_STRING_FORMAT, HOSTNAME, count));
      }
```

**Note:** The file is saved automatically.

Rebuild and redeploy the recommendation microservices.

Go to the recommendation folder `cd ~/projects/istio-tutorial/recommendation-v2/`{{execute}}

Compile the project with the modifications that you did.

`mvn package`{{execute}}

Execute `docker build -t example/recommendation:v2 .`{{execute}}

You can check the image that was create by typing `docker images | grep recommendation`{{execute}}

Now let's delete the previous v2 pod to force the creation of a new pod using the new image.

`oc delete pod -l app=recommendation,version=v2 -n tutorial`{{execute}}

## Timeout rule

Check the file `/istiofiles/route-rule-recommendation-timeout.yml`{{open}}.

Note that this `RouteRule` provides a `simpleTimeout` of `1 second`.

Let's apply this rule: `oc create -f ~/projects/istio-tutorial/istiofiles/route-rule-recommendation-timeout.yml -n tutorial`{{execute}}

You will see it return `v1` OR `503` after waiting about 1 second, although v2 takes 3 seconds to complete.

To check the new behaviour, try the microservice several times by typing `while true; do time curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute}}

Hit CTRL+C when you are satisfied.

## Cleanup

To remove the Timeout behaviour, simply delete this `routerule` by executing `oc delete routerule recommendation-timeout -n tutorial`{{execute}}

To check if you have random load-balance, try the microservice several times by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

