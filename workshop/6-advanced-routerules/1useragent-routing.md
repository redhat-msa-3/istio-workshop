What is your user-agent?

<https://www.whoishostingthis.com/tools/user-agent/>

**Note:** the "user-agent" header being forwarded in the Customer and Preferences controllers in order for route rule modications around recommendations

Let's create a rule that points all request to v1 using the [route-rule-recommendations-v1.yml](https://github.com/redhat-developer-demos/istio-tutorial/blob/master/istiofiles/route-rule-recommendations-v1.yml) file

`oc create -f istiofiles/route-rule-recommendations-v1.yml -n tutorial`{{execute}}

Check this behaviour trying the microservice several times by typing `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute}}

Hit CTRL+C when you are satisfied.

Now test the URL http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com with a Safari (or even Chrome on Mac since it includes Safari in the string). Safari only sees v2 responses from recommendations

and test with a Firefox browser, it should only see v1 responses from recommendations.


## Try this rule using curl

If you don't have these browsers you can customiza the `curl` command `user-agent` using `-A`.

For example. Try `curl -A Safari http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

Alternatively you can try `curl -A Firefox http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

You can describe the routerule to see its configuration: `oc describe routerule recommendations-safari -n tutorial`{{execute}} 

## Cleanup

To remove the User-Agent behaviour, simply delete this `routerule` by executing `oc delete routerule recommendations-safari -n tutorial`{{execute}}

To check if you have random load-balance, try the microservice several times by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}


