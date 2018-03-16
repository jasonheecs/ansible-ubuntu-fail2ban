.PHONY: test
test:
	mkdir -p tests/roles/ansible-ubuntu-fail2ban/defaults/
	rsync -avzh --relative ./defaults ./handlers ./tasks ./templates tests/roles/ansible-ubuntu-fail2ban/
	ansible-playbook tests/test.yml --syntax-check
	cd tests && ./tests.sh

.PHONY: clean
clean:
	rm -rf tests/roles/ansible-ubuntu-fail2ban