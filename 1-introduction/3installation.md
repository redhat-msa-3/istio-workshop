To install Istio in the cluster, we need first to make sure that we are logged in as an `system:admin` user.

To log in the OpenShift cluster, type `oc login -u system:admin`{{execute}}

Now that you are logged in, it's time to download `Istio` distribution.

Execute: `wget https://github.com/istio/istio/releases/download/0.4.0/istio-0.4.0-linux.tar.gz `{{execute}}

Once that you have downloaded the file, it's time to extract it.

To extract Istio distribution execute `tar -zxvf istio-0.4.0-linux.tar.gz`{{execute}}

## Before the installation

Istio will be installed on a project/namespace called istio-system.

*"OpenShift provides security context constraints (SCC) that control the actions that a pod can perform and what it has the ability to access."*

Because of SCC, we need to allow the Istio service account to execute images with any user id.
There's a SCC called `anyuid` that needs to be associated with Istio service accounts.

Execute the following commands

`oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system`{{execute}}

`oc adm policy add-scc-to-user anyuid -z istio-egress-service-account -n istio-system`{{execute}}

`oc adm policy add-scc-to-user anyuid -z default -n istio-system`{{execute}}

To understand more about SCC, we recommend you to read [Understanding Service Accounts and SCCs](https://blog.openshift.com/understanding-service-accounts-sccs/)

## Continue the installation

Istio provides a file `install/kubernetes/istio.yaml` that contains the definition of all objects that needs to be created in the Kubernetes cluster.

Let's apply these defintions to the cluster by executing `oc apply -f istio-0.4.0/install/kubernetes/istio.yaml`{{execute}}

After the execution, Istio objects will be created.

To watch the creation of the pods, execute `oc get pods -w -n istio-system`{{execute}}

Once that they are all `Running`, you hit `CTRL+C`. This concludes this scenario.

