.PHONY: help site quarto-site preview slides slides-build nojekyll publish hello hello-run hello-gdb clean

LESSON ?= lessons/aarch64/01-laboratorio/00-hello-minimo/src
SLIDES ?= slides/aarch64/laboratorio/overview/slides.md
SLIDES_OUT ?= $(CURDIR)/_site/slides/aarch64/laboratorio/overview
SLIDES_TMP ?= $(dir $(SLIDES)).slidev-dist

help:
	@echo "Targets:"
	@echo "  make site       Render Quarto site and build Slidev decks"
	@echo "  make publish    Render locally and publish to GitHub Pages"
	@echo "  make quarto-site Render only Quarto pages"
	@echo "  make preview    Preview Quarto site"
	@echo "  make slides     Run Slidev for the current deck"
	@echo "  make slides-build Build current Slidev deck into _site"
	@echo "  make hello      Build first AArch64 lesson"
	@echo "  make hello-run  Run first AArch64 lesson"
	@echo "  make hello-gdb  Start first AArch64 lesson under GDB server"
	@echo "  make clean      Clean generated lesson artifacts"

site: quarto-site

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
		pnpm exec slidev build "$(SLIDES)" --out ".slidev-dist" --base ./ --router-mode hash; \
		rm -rf "$(SLIDES_OUT)"; \
		mkdir -p "$(SLIDES_OUT)"; \
		cp -R "$(SLIDES_TMP)/." "$(SLIDES_OUT)"; \
		rm -rf "$(SLIDES_TMP)"; \
	else \
		echo "Slidev deck not found at $(SLIDES); skipping."; \
	fi

nojekyll:
	touch _site/.nojekyll

publish: site
	quarto publish gh-pages --no-browser --no-prompt

hello:
	$(MAKE) -C $(LESSON)

hello-run:
	$(MAKE) -C $(LESSON) run

hello-gdb:
	$(MAKE) -C $(LESSON) gdb

clean:
	$(MAKE) -C $(LESSON) clean
