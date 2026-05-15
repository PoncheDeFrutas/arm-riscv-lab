.PHONY: help site quarto-site preview slides slides-build nojekyll publish hello hello-run hello-gdb clean

SITE_DIR ?= site
LESSON ?= projects/aarch64/minimo/src
SLIDE_ROOT ?= $(SITE_DIR)/slides
SLIDES ?= $(SLIDE_ROOT)/aarch64/01-laboratorio-arm64-reproducible.md
SLIDE_DECKS ?= \
	$(SLIDE_ROOT)/aarch64/00-semana-diagnostico.md \
	$(SLIDE_ROOT)/aarch64/contexto-historia-objetivos.md \
	$(SLIDE_ROOT)/aarch64/01-laboratorio-arm64-reproducible.md \
	$(SLIDE_ROOT)/aarch64/02-bases-binarias-representacion.md \
	$(SLIDE_ROOT)/aarch64/03-modelo-aarch64.md \
	$(SLIDE_ROOT)/aarch64/04-gnu-assembly-directivas.md \
	$(SLIDE_ROOT)/aarch64/05-primeros-programas.md \
	$(SLIDE_ROOT)/aarch64/06-memoria-direccionamiento.md \
	$(SLIDE_ROOT)/aarch64/07-aritmetica-logica-bits.md \
	$(SLIDE_ROOT)/aarch64/08-control-flujo.md \
	$(SLIDE_ROOT)/aarch64/09-syscalls-esenciales.md \
	$(SLIDE_ROOT)/aarch64/10-linux-api-kernel.md \
	$(SLIDE_ROOT)/aarch64/11-stack-funciones-frames.md \
	$(SLIDE_ROOT)/aarch64/12-heap-memoria-dinamica.md \
	$(SLIDE_ROOT)/aarch64/13-mmap-paginas-permisos.md \
	$(SLIDE_ROOT)/aarch64/14-layout-datos-structs.md \
	$(SLIDE_ROOT)/aarch64/15-abi-aapcs64-c.md \
	$(SLIDE_ROOT)/aarch64/16-elf-linking-loading.md \
	$(SLIDE_ROOT)/aarch64/17-debugging-gdb-qemu-strace.md
SLIDEV ?= node_modules/.bin/slidev

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
	rm -rf _site
	quarto render $(SITE_DIR)

preview:
	quarto preview $(SITE_DIR)

slides:
	@if [ -f "$(SLIDES)" ]; then \
		deck="$(SLIDES)"; \
		deck="$${deck#$(SLIDE_ROOT)/}"; \
		if [ -x "$(SLIDE_ROOT)/$(SLIDEV)" ]; then \
			(cd "$(SLIDE_ROOT)" && "./$(SLIDEV)" "$$deck"); \
		else \
			(cd "$(SLIDE_ROOT)" && pnpm exec slidev "$$deck"); \
		fi; \
	else \
		echo "Slidev deck not found at $(SLIDES); skipping."; \
	fi

slides-build:
	@set -e; \
	for deck in $(SLIDE_DECKS); do \
		if [ -f "$$deck" ]; then \
			rel="$${deck#$(SITE_DIR)/}"; \
			inner="$${deck#$(SLIDE_ROOT)/}"; \
			out="$(CURDIR)/_site/$${rel%.md}"; \
			tmp="$$(mktemp -d "$(CURDIR)/.slidev-dist.XXXXXX")"; \
			if [ -x "$(SLIDE_ROOT)/$(SLIDEV)" ]; then \
				(cd "$(SLIDE_ROOT)" && "./$(SLIDEV)" build "$$inner" --out "$$tmp" --base ./ --router-mode hash); \
			else \
				(cd "$(SLIDE_ROOT)" && pnpm exec slidev build "$$inner" --out "$$tmp" --base ./ --router-mode hash); \
			fi; \
			rm -rf "$$out"; \
			mkdir -p "$$out"; \
			cp -R "$$tmp/." "$$out"; \
			rm -rf "$$tmp"; \
		else \
			echo "Slidev deck not found at $$deck; skipping."; \
		fi; \
	done

nojekyll:
	touch _site/.nojekyll

publish: site
	quarto publish gh-pages $(SITE_DIR) --no-browser --no-prompt

hello:
	$(MAKE) -C $(LESSON)

hello-run:
	$(MAKE) -C $(LESSON) run

hello-gdb:
	$(MAKE) -C $(LESSON) gdb

clean:
	$(MAKE) -C $(LESSON) clean
