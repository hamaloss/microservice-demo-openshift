#!/bin/bash

oc new-project microservice-demo-test
oc project microservice-demo-test
oc create serviceaccount pusher
oc policy add-role-to-user edit system:serviceaccount:microservice-demo-test:pusher
oc create -f microservice-demo-test-project.json

oc new-project microservice-demo-uat
oc project microservice-demo-uat
oc policy add-role-to-group system:image-puller system:serviceaccounts:microservice-demo-uat -n microservice-demo-test
oc create -f microservice-demo-uat-project.json

oc new-project microservice-demo-prod
oc project microservice-demo-prod
oc policy add-role-to-group system:image-puller system:serviceaccounts:microservice-demo-prod -n microservice-demo-test
oc create -f microservice-demo-prod-project.json

oc project microservice-demo-test
oc describe sa pusher

echo "Run 'oc describe secret <token-name>' to get the secret token for imager repository account"
