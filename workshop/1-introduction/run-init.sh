#!/bin/bash
ssh root@host01 "rm -rf /root/projects/rhoar-getting-started/ /root/temp-pom.xml"
ssh root@host01 "until $(oc get svc router -n default&> /dev/null); do sleep 1; done; oc login -u system:admin; oc adm policy add-cluster-role-to-user cluster-admin admin"

