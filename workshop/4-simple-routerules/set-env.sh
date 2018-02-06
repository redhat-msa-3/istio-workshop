~/.launch.sh
until $(oc get deployment recommendation-v1 -n tutorial &> /dev/null); do   sleep 1; done
export PATH=$PATH:/root/installation/istio-0.5.0/bin/
