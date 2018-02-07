## White list

We'll create a whitelist on the preference service to only allow requests from the recommendation service, which will make the preference service invisible to the customer service. Requests from the customer service to the preference service will return a 404 Not Found HTTP error code.

Inspect the file `/istiofiles/acl-whitelist.yml`{{open}}.

Now lest's use apply this file through `istioctl create -f ~/projects/istio-tutorial/istiofiles/acl-whitelist.yml -n tutorial`{{execute}}

Check the new behaviour trying the microservice by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

You should see `customer => 404 NOT_FOUND:preferencewhitelist.listchecker.tutorial:customer is not whitelisted`

To reset the environment type `istioctl delete -f ~/projects/istio-tutorial/istiofiles/acl-whitelist.yml -n tutorial`{{execute}}

## Blacklist

We'll create a blacklist making the customer service blacklist to the preference service. Requests from the customer service to the preference service will return a 403 Forbidden HTTP error code.


Inspect the file `/istiofiles/acl-blacklist.yml`{{open}}.

Now lest's use apply this file through `istioctl create -f ~/projects/istio-tutorial/istiofiles/acl-blacklist.yml -n tutorial`{{execute}}

Check the new behaviour trying the microservice by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

You should see `customer => 403 PERMISSION_DENIED:denycustomerhandler.denier.tutorial:Not allowed`

To reset the environment type `istioctl delete -f ~/projects/istio-tutorial/istiofiles/acl-blacklist.yml -n tutorial`{{execute}}
