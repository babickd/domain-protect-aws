# Creates the default virtual environment to run.

.PHONY: env
env:
	pyenv uninstall -f domain-protect-3.9.1
	pyenv virtualenv 3.9.1 domain-protect-3.9.1

# Generates the requirements.txt file without installing the dependencies.

.PHONY: reqs
reqs:
	pip install --upgrade pip pip-tools
	pip-compile --no-emit-index-url
	pip-compile --no-emit-index-url requirements-dev.in

# Installs dependencies needed to run the project.

.PHONY: deps
deps: reqs
	pip install --upgrade pip pip-tools
	pip-sync requirements.txt requirements-dev.txt

# Upgrades and installs all project dependencies.

.PHONY: upgrade
upgrade:
	pip install --upgrade pip pip-tools
	pip-compile --upgrade --no-emit-index-url
	pip-compile --upgrade --no-emit-index-url requirements-dev.in
	pip-sync requirements.txt requirements-dev.txt

# Builds Docker image, loads into local cluster and deploys via Helm,

.PHONY: skaffold-dev
skaffold-dev:
	skaffold dev --port-forward
