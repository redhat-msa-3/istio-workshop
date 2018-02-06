Before we start this scenario, we need to deploy all microservices (customer, preferences, recommendations[v1:v2]).

There's a script called `install-microservices.sh` that will

- Checkout the source code from https://github.com/redhat-developer-demos/istio-tutorial
- Create recommendations:v2
- Run `mvn package` on all projects
- Create a docker image
- Deploy the microservices with the sidecar proxy

Make this script executable `chmod +x install-microservices.sh`{{execute}}

Now you can execute this script: `./install-microservices.sh`{{execute}}

> The script will take between 2-5 minutes to complete.

When the scripts ends, watch the creation of the pods, execute `oc get pods -w`{{execute}}

Once that the microservices pods READY column are 2/2, you can hit `CTRL+C`. 

Try the microservice by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

It should return:

`customer => preference => recommendation v1 from {hostname}: 1`