#!/bin/bash

set -e

ansible-container build && ansible-container run

# Run the role again, checking to make sure it's idempotent.
idempotence=$(mktemp)
ansible-container run 2>&1 | tee -a ${idempotence}
tail ${idempotence} | grep 'changed=0.*failed=0' && (echo 'Idempotence test: pass' && exit 0) || (echo 'Idempotence test: fail' && exit 1)

docker exec -it fail2bantests_trusty_1 sudo service fail2ban start

ansible-container destroy