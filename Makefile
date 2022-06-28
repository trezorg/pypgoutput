.PHONY: test
test:
	./tests/run_tests_locally.sh

.PHONY: mypy
mypy:
	${PYTHON} -m mypy src/ tests/

.PHONY: format
format: venv
	${PYTHON} -m isort src/ tests/
	${PYTHON} -m black --config=pyproject.toml src/ tests/

.PHONY: lint
lint:
	poetry run pflake8 .
	poetry run mypy src

publish: lint test
	echo yes | poetry publish --build -v -r echo

.PHONY: clean
clean:
	rm -rf $(VENV)
	find . -type f -name *.pyc -delete
	find . -type d -name __pycache__ -delete
