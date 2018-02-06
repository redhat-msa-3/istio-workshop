ssh root@host01 "rm -rf /root/projects/rhoar-getting-started/ /root/temp-pom.xml"
ssh root@host01 "oc login -u system:admim"
ssh root@host01 "oc adm policy add-cluster-role-to-user cluster-admin developer"
