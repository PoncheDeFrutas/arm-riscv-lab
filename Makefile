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
	export JOBS=$$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4); \
	echo "Building $$JOBS slide decks in parallel..."; \
	for deck in $(SLIDE_DECKS); do \
		if [ -f "$$deck" ]; then \
			rel="$${deck#$(SITE_DIR)/}"; \
			inner="$${deck#$(SLIDE_ROOT)/}"; \
			out="$(CURDIR)/_site/$${rel%.md}"; \
			src_mod=$$(stat -c %Y "$$deck" 2>/dev/null || stat -f %m "$$deck" 2>/dev/null || echo 0); \
			if [ -d "$$out" ]; then \
				out_mod=$$(find "$$out" -type f -newer "$$deck" 2>/dev/null | head -1); \
				if [ -n "$$out_mod" ]; then \
					echo "SKIP (up to date): $$inner"; \
					continue; \
				fi; \
			fi; \
			echo "BUILD: $$inner"; \
			tmp="$$(mktemp -d "$(CURDIR)/.slidev-dist.XXXXXX")"; \
			(cd "$(SLIDE_ROOT)" && pnpm exec slidev build "$$inner" --out "$$tmp" --base ./ --router-mode hash) & \
			while [ $$(jobs -r | wc -l) -ge $$JOBS ]; do sleep 0.5; done; \
			echo "$$tmp $$out" >> "$(CURDIR)/.slidev-pending"; \
		else \
			echo "Slidev deck not found at $$deck; skipping."; \
		fi; \
	done; \
	wait; \
	if [ -f "$(CURDIR)/.slidev-pending" ]; then \
		while IFS=' ' read -r tmp out; do \
			rm -rf "$$out"; \
			mkdir -p "$$out"; \
			cp -R "$$tmp/." "$$out"; \
			rm -rf "$$tmp"; \
		done < "$(CURDIR)/.slidev-pending"; \
		rm -f "$(CURDIR)/.slidev-pending"; \
	fi

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
