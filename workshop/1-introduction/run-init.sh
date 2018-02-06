#!/bin/bash
ssh root@host01 "rm -rf /root/projects/rhoar-getting-started/ /root/temp-pom.xml"
ssh root@host01 "until $(oc status &> /dev/null); do sleep 1; done; oc adm policy add-cluster-role-to-user cluster-admin admin"

