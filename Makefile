.PHONY: install install-lefthook hooks

install: install-lefthook hooks

install-lefthook:
	@scripts/ci/install-lefthook.sh

hooks:
	@lefthook install
