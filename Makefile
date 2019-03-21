# -*- makefile -*-
.PHONY: main clean test pip supy docs

# OS-specific configurations
ifeq ($(OS),Windows_NT)
	PYTHON_exe = python.exe

else
	UNAME_S := $(shell uname -s)


	ifeq ($(UNAME_S),Linux) # Linux
		PYTHON_exe=python

	endif

	ifeq ($(UNAME_S),Darwin) # macOS
		PYTHON_exe=python

	endif

endif

src_dir = atmosp
docs_dir = docs


PYTHON := $(if $(PYTHON_exe),$(PYTHON_exe),python)
# All the files which include modules used by other modules (these therefore
# need to be compiled first)

MODULE = atmosp

# default make options
main:
	python setup.py bdist_wheel

# house cleaning
clean:
	python setup.py clean
	rm -rf dist/*

# run test
test:
	$(MAKE) clean
	$(MAKE) main
	python setup.py test

# make docs and open index
docs:
	$(MAKE) -C $(docs_dir) html
	open $(docs_dir)/build/html/index.html

# upload wheels to pypi using twine
upload:
	twine upload --skip-existing dist/*

# upload wheels to pypi using twine
livehtml:
	$(MAKE) -C $(docs_dir) livehtml