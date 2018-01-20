Before we start this scenario, we need to deploy all microservices (customer, preferences, recommendations[v1:v2]).

There's a script called `install-microservices.sh` that will

- Checkout the source code from https://github.com/redhat-developer-demos/istio-tutorial
- Install Java and Maven
- Create recommendations:v2
- Run `mvn package` on all projects
- Create a docker image
- Deploy the microservices with the sidecar proxy

Execute this script: `./install-microservices.sh`{{execute}}

When the scripts ends, watch the creation of the pods, execute `oc get pods -w`{{execute}}

Once that the microservices pods READY column are 2/2, you can hit `CTRL+C`. 

Try the microservice by typing `curl http://customer-tutorial.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

It should return:

`C100 *{"P1":"Red", "P2":"Big"} && Clifford v1 1 *`
