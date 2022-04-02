PKGNAME=geofred

build: 
	python3 setup.py sdist bdist_wheel

upload: 
	python3 -m twine upload dist/*

upload-testpypi: build
	python3 -m twine upload -repository testpypi dist/*

install-testpypi: 
	pip uninstall $(PKGNAME)
	pip install -i https://test.pypi.org/$(PKGNAME) $(PKGNAME)

install-local: build 
	pip install -e .

help: start 

start: 
	@echo 
	@echo "--- INSTRUCTIONS ---"
	@echo "0- create new environment"
	@echo "   > python3 -m venv .pyenv"
	@echo "1- activate your environment"
	@echo "   > source .pyenv/bin/activate"
	@echo "2- install dependencies"
	@echo "   > pip install -r requirements.pip"