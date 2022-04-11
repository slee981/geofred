PKGNAME=geofred

# which build formula do I use? 
# python3 setup.py sdist bdist_wheel
build-project: 
	. .pyenv/bin/activate && python3 -m build

upload: clean build-project
	. .pyenv/bin/activate && \
	python3 -m twine upload dist/*

upload-testpypi: clean build-project
	. .pyenv/bin/activate && python3 -m twine upload --verbose --repository testpypi dist/*

install-testpypi: upload-testpypi
	pip uninstall $(PKGNAME)
	pip install -i https://test.pypi.org/simple $(PKGNAME)

install-local: build-project
	pip uninstall $(PKGNAME)
	pip install -e .

clean: 
	rm -rf dist/*

uninstall: 
	pip uninstall geofred

env: 
	. .pyenv/bin/activate

test: 
	pytest

help: start 

start: 
	@echo 
	@echo "--- INSTRUCTIONS ---"
	@echo "0- create new environment"
	@echo "   > python3 -m venv .pyenv"
	@echo "1- activate your environment"
	@echo "   > source .pyenv/bin/activate"
	@echo "2- install dependencies"
	@echo "   > make devenv"

devenv: 
	pip install --upgrade pip && \
	pip install --require-virtualenv -r requirements.pip