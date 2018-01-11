Tracing requires a bit of work on the Java side. Each microservice needs to pass on the headers which are used to enable the traces.

Look at https://github.com/redhat-developer-demos/istio_tutorial/blob/master/customer/src/main/java/com/example/customer/CustomerController.java#L21-L42

and 

https://github.com/redhat-developer-demos/istio_tutorial/blob/master/customer/src/main/java/com/example/customer/CustomerController.java#L49

## Install Jaeger console

Jaeger allow you to trace the invocation.

Install Jaeger console by executing: `oc process -f https://raw.githubusercontent.com/jaegertracing/jaeger-openshift/master/all-in-one/jaeger-all-in-one-template.yml | oc create -f -`{{execute}}