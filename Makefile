DATE = $(shell date)
.PHONY: run test upload

all: release
upload:
	@./upload

release:
	@echo "Commit message:"
	@read REPLY; \
	echo "${DATE} - $$REPLY" >> CHANGELOG && \
	git add --all && \
	git commit -m "$$REPLY" && \
	git push