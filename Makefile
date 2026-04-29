.PHONY: help site quarto-site preview slides slides-build hello hello-run hello-gdb clean

LESSON ?= lessons/aarch64/02-syscalls/00-hello-world
SLIDES ?= slides/aarch64/02-syscalls/00-hello-world/slides.md

help:
	@echo "Targets:"
	@echo "  make site       Render Quarto site and build Slidev decks"
	@echo "  make quarto-site Render only Quarto pages"
	@echo "  make preview    Preview Quarto site"
	@echo "  make slides     Run Slidev for the first deck"
	@echo "  make slides-build Build first Slidev deck into _site"
	@echo "  make hello      Build first AArch64 lesson"
	@echo "  make hello-run  Run first AArch64 lesson"
	@echo "  make hello-gdb  Start first AArch64 lesson under GDB server"
	@echo "  make clean      Clean generated lesson artifacts"

site: quarto-site slides-build

quarto-site:
	quarto render

preview:
	quarto preview

slides:
	pnpm exec slidev $(SLIDES)

slides-build:
	pnpm run slides:build

hello:
	$(MAKE) -C $(LESSON)

hello-run:
	$(MAKE) -C $(LESSON) run

hello-gdb:
	$(MAKE) -C $(LESSON) gdb

clean:
	$(MAKE) -C $(LESSON) clean
