By default, you will see "round-robin" style load-balancing, but you can change it up, with the RANDOM option being fairly visible to the naked eye.

Add another v2 pod to the mix `oc scale deployment recommendation-v2 --replicas=2 -n tutorial`{{execute T1}}

Watch the creation of the pods executing `oc get pods -w`{{execute T1}}

Once that the recommendation pods READY column are 2/2, you can hit `CTRL+C`. 

Try the microservices many times by typing `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute T1}}

Hit CTRL+C when you are satisfied.

Add a 3rd v2 pod to the mix `oc scale deployment recommendation-v2 --replicas=3 -n tutorial`{{execute T1}}

Watch the creation of the pods executing `oc get pods -w`{{execute T1}}

Once that the recommendation pods READY column are 2/2, you can hit `CTRL+C`. 

Try the microservices many times by typing `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute T1}}

The results should follow a fairly normal round-robin distribution pattern where `v2` receives the request 3 times more than `v1`

```
customer => preference => recommendation v1 from '99634814-d2z2t': 1145
customer => preference => recommendation v2 from '2819441432-525lh': 1
customer => preference => recommendation v2 from '2819441432-rg45q': 2
customer => preference => recommendation v2 from '2819441432-bs5ck': 181
customer => preference => recommendation v1 from '99634814-d2z2t': 1146
customer => preference => recommendation v2 from '2819441432-rg45q': 3
customer => preference => recommendation v2 from '2819441432-rg45q': 4
customer => preference => recommendation v2 from '2819441432-bs5ck': 182
```
Hit CTRL+C when you are satisfied.

Now, explore the file `istiofiles/recommendation_lb_policy_app.yml`{{open}}, and add the Random LB DestinationPolicy:

`oc create -f ~/projects/istio-tutorial/istiofiles/recommendation_lb_policy_app.yml -n tutorial`{{execute T1}}

Execute `while true; do curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com; sleep .1; done`{{execute T1}}`

After a while you should see a different pattern.

Hit CTRL+C when you are satisfied.

## Clean up

Execute `oc delete -f ~/projects/istio-tutorial/istiofiles/recommendation_lb_policy_app.yml -n tutorial`{{execute T1}}

and 

`oc scale deployment recommendation-v2 --replicas=1 -n tutorial`{{execute T1}}