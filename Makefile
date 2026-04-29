.PHONY: help site quarto-site preview slides slides-build nojekyll publish hello hello-run hello-gdb clean

LESSON ?= lessons/aarch64/02-syscalls/00-hello-world
SLIDES ?= slides/aarch64/02-syscalls/00-hello-world/slides.md
SLIDES_OUT ?= _site/slides/aarch64/02-syscalls/00-hello-world

help:
	@echo "Targets:"
	@echo "  make site       Render Quarto site and build Slidev decks"
	@echo "  make publish    Render locally and publish to GitHub Pages"
	@echo "  make quarto-site Render only Quarto pages"
	@echo "  make preview    Preview Quarto site"
	@echo "  make slides     Run Slidev for the first deck"
	@echo "  make slides-build Build first Slidev deck into _site"
	@echo "  make hello      Build first AArch64 lesson"
	@echo "  make hello-run  Run first AArch64 lesson"
	@echo "  make hello-gdb  Start first AArch64 lesson under GDB server"
	@echo "  make clean      Clean generated lesson artifacts"

site: quarto-site slides-build nojekyll

quarto-site:
	quarto render

preview:
	quarto preview

slides:
	@if [ -f "$(SLIDES)" ]; then \
		pnpm exec slidev "$(SLIDES)"; \
	else \
		echo "Slidev deck not found at $(SLIDES); skipping."; \
	fi

slides-build:
	@if [ -f "$(SLIDES)" ]; then \
		pnpm exec slidev build "$(SLIDES)" --out "$(SLIDES_OUT)" --base ./ --router-mode hash; \
	else \
		echo "Slidev deck not found at $(SLIDES); skipping."; \
	fi

nojekyll:
	touch _site/.nojekyll

publish: site
	quarto publish gh-pages --no-render --no-browser

hello:
	$(MAKE) -C $(LESSON)

hello-run:
	$(MAKE) -C $(LESSON) run

hello-gdb:
	$(MAKE) -C $(LESSON) gdb

clean:
	$(MAKE) -C $(LESSON) clean
