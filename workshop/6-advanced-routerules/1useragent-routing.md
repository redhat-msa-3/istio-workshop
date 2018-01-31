What is your user-agent?

<https://www.whoishostingthis.com/tools/user-agent/>

**Note:** the "user-agent" header being forwarded in the Customer and Preferences controllers in order for route rule modications around recommendations.

To watch the creation of the pods, execute `oc get pods -w`{{execute}}

Once that the recommendations pods READY column are 2/2, you can hit `CTRL+C`. 

Let's create a rule that points all request to v1 using the [route-rule-recommendations-v1.yml](https://github.com/redhat-developer-demos/istio-tutorial/blob/master/istiofiles/route-rule-recommendations-v1.yml) file.

`oc create -f istio-tutorial/istiofiles/route-rule-recommendations-v1.yml -n tutorial`{{execute}}

Check this behaviour trying the microservice several times by typing `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute}}

Hit CTRL+C when you are satisfied.

Now check the file [route-rule-safari-recommendations-v2.yml](https://github.com/redhat-developer-demos/istio-tutorial/blob/master/istiofiles/route-rule-safari-recommendations-v2.yml).

Note that this `RouteRule` will only route request to `recommendations` that contains the label `version=v2` when the `request` contains a `header` where the `user-agent` value `matches` the `regex` expression to `".*Safari.*"`.

Let's apply this rule: `oc create -f istio-tutorial/istiofiles/route-rule-safari-recommendations-v2.yml -n tutorial`{{execute}}

Now test the URL http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com with a Safari (or even Chrome on Mac since it includes Safari in the string). Safari only sees v2 responses from recommendations

and test with a Firefox browser, it should only see v1 responses from recommendations.


## Try this rule using curl

If you don't have these browsers you can customiza the `curl` command `user-agent` using `-A`.

For example. Try `curl -A Safari http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

Alternatively you can try a `Firefox` user-agent with `curl -A Firefox http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

You can describe the routerule to see its configuration: `oc describe routerule recommendations-safari -n tutorial`{{execute}} 

## Remove 'Safari' rule.

To remove the User-Agent behaviour, simply delete this `routerule` by executing `oc delete routerule recommendations-safari -n tutorial`{{execute}}

To check if you have all requests using `v1`, try the microservice several times by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

You still have the requests going to `v1` because you didn't remove the RouteRule `recommendations-default`.
