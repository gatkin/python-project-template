SRC_DIR=src
TEST_DIR=tests

coverage:
	python -m coverage run ${TEST_DIR}/run_tests.py -v --junit-xml=test_results/test_results.xml
	python -m coverage report
	python -m coverage html

format:
	python -m black ${SRC_DIR}/ ${TEST_DIR}/

install:
	python -m pip install -U pip
	python -m pip install -U pipenv
	python -m pipenv sync --dev

lint: type-check
	python -m black --check ${SRC_DIR}/ ${TEST_DIR}/
	python -m flake8 --max-complexity 10 ${SRC_DIR}/
	python -m pydocstyle ${SRC_DIR}/
	python -m pylint --rcfile ${SRC_DIR}/.pylintrc ${SRC_DIR}/

per-commit: lint coverage

setup:
	python3 -m pipenv install --dev
	python3 -m pipenv shell

test:
	python -m pytest -vv

type-check:
	python -m mypy ${SRC_DIR}/
