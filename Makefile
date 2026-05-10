.PHONY: help site quarto-site preview slides slides-build nojekyll publish hello hello-run hello-gdb clean

SITE_DIR ?= site
LESSON ?= projects/aarch64/minimo/src
SLIDES ?= $(SITE_DIR)/slides/aarch64/laboratorio/01-laboratorio-arm64-reproducible/slides.md
SLIDE_DECKS ?= $(SITE_DIR)/slides/aarch64/fundamentos/contexto-historia-objetivos/slides.md $(SITE_DIR)/slides/aarch64/laboratorio/01-laboratorio-arm64-reproducible/slides.md $(SITE_DIR)/slides/aarch64/bases-binarias/02-bases-binarias-representacion/slides.md $(SITE_DIR)/slides/aarch64/modelo-aarch64/03-modelo-aarch64/slides.md $(SITE_DIR)/slides/aarch64/gnu-assembly/04-gnu-assembly-directivas/slides.md $(SITE_DIR)/slides/aarch64/primeros-programas/05-primeros-programas/slides.md $(SITE_DIR)/slides/aarch64/memoria-direccionamiento/06-memoria-direccionamiento/slides.md $(SITE_DIR)/slides/aarch64/aritmetica-logica-bits/07-aritmetica-logica-bits/slides.md $(SITE_DIR)/slides/aarch64/control-flujo/08-control-flujo/slides.md $(SITE_DIR)/slides/aarch64/syscalls-esenciales/09-syscalls-esenciales/slides.md $(SITE_DIR)/slides/aarch64/linux-api-kernel/10-linux-api-kernel/slides.md $(SITE_DIR)/slides/aarch64/stack-funciones-frames/11-stack-funciones-frames/slides.md $(SITE_DIR)/slides/aarch64/heap-memoria-dinamica/12-heap-memoria-dinamica/slides.md $(SITE_DIR)/slides/aarch64/mmap-paginas-permisos/13-mmap-paginas-permisos/slides.md $(SITE_DIR)/slides/aarch64/layout-datos-structs/14-layout-datos-structs/slides.md $(SITE_DIR)/slides/aarch64/abi-aapcs64-c/15-abi-aapcs64-c/slides.md $(SITE_DIR)/slides/aarch64/elf-linking-loading/16-elf-linking-loading/slides.md $(SITE_DIR)/slides/aarch64/debugging-gdb-qemu-strace/17-debugging-gdb-qemu-strace/slides.md
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
		deck="$$(printf '%s\n' "$(SLIDES)" | sed 's#^$(SITE_DIR)/##')"; \
		if [ -x "$(SITE_DIR)/$(SLIDEV)" ]; then \
			cd "$(SITE_DIR)" && "./$(SLIDEV)" "$$deck"; \
		else \
			cd "$(SITE_DIR)" && pnpm exec slidev "$$deck"; \
		fi; \
	else \
		echo "Slidev deck not found at $(SLIDES); skipping."; \
	fi

slides-build:
	@set -e; \
	for deck in $(SLIDE_DECKS); do \
		if [ -f "$$deck" ]; then \
			rel="$${deck#$(SITE_DIR)/}"; \
			inner="$${deck#$(SITE_DIR)/}"; \
			out="$(CURDIR)/_site/$${rel%/slides.md}"; \
			tmp="$(CURDIR)/$${deck%/slides.md}/.slidev-dist"; \
			if [ -x "$(SITE_DIR)/$(SLIDEV)" ]; then \
				cd "$(SITE_DIR)" && "./$(SLIDEV)" build "$$inner" --out "$$tmp" --base ./ --router-mode hash; \
			else \
				cd "$(SITE_DIR)" && pnpm exec slidev build "$$inner" --out "$$tmp" --base ./ --router-mode hash; \
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
