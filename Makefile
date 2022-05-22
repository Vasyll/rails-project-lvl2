test:
	bin/rails test

setup:
	bundle install

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/

.PHONY: test