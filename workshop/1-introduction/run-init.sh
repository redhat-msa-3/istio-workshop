#!/bin/bash
ssh root@host01 "git --work-tree=/root/projects/istio-tutorial/ --git-dir=/root/projects/istio-tutorial/.git pull"
ssh root@host01 "rm -rf /root/projects/rhoar-getting-started/ /root/temp-pom.xml"
ssh root@host01 "sleep 10; oc login -u system:admin; oc adm policy add-cluster-role-to-user cluster-admin admin"

