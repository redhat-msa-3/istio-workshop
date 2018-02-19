#!/bin/bash
ssh root@host01 "git --work-tree=/root/projects/istio-tutorial/ --git-dir=/root/projects/istio-tutorial/.git pull"
ssh root@host01 "rm -rf /root/projects/* /root/temp-pom.xml"
ssh root@host01 "until $(oc get project istio-system &> /dev/null); do sleep 1; done; oc login -u system:admin; oc adm policy add-cluster-role-to-user cluster-admin admin"

