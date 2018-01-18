We will deploy three microservices (customer, preferences, recommendations) implemented using Spring Boot.

The `customer` microservice makes a request to `preferences` that makes a request to `recommendations`.

Let's deploy each one of them to a new project called `tutorial`.

To create a new project, execute `oc new-project tutorial`{{execute}}

Now let's add the `privileged` SCC to this project.

Execute: `oc adm policy add-scc-to-user privileged -z default -n tutorial`{{execute}}
