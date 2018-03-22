.PHONY: run-tests
run-tests: test-trusty test-xenial

.PHONY: test-trusty
test-trusty:
	mv tests/container-trusty.yml tests/container.yml
	make test
	cd tests && ./tests.sh trusty
	mv tests/container.yml tests/container-trusty.yml

.PHONY: test-xenial
test-xenial:
	mv tests/container-xenial.yml tests/container.yml
	make test
	cd tests && ./tests.sh xenial
	mv tests/container.yml tests/container-xenial.yml

.PHONY: test
test:
	mkdir -p tests/roles/ansible-ubuntu-fail2ban/defaults/
	rsync -avzh --relative ./defaults ./handlers ./tasks ./templates tests/roles/ansible-ubuntu-fail2ban/
	ansible-playbook tests/test.yml --syntax-check

.PHONY: clean
clean:
	rm -rf tests/roles/ansible-ubuntu-fail2ban