# Derrived from https://github.com/dpw/selinux-dockersock
POLICY_NAME		?= docker-sock-connect

.PHONY: load
load: $(POLICY_NAME).pp
	semodule -i $^

.PHONY: unload
unload:
	semodule -r $(POLICY_NAME)

$(POLICY_NAME).mod: $(POLICY_NAME).te
	checkmodule -M -m $< -o $@

$(POLICY_NAME).pp: $(POLICY_NAME).mod
	semodule_package -m $< -o $@

.PHONY: clean
clean::
	rm -f $(POLICY_NAME).pp $(POLICY_NAME).mod
