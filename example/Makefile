
.PHONY: all
all: plan.pdf

.PHONY: clean
clean:
	rm -f *.svg *.pdf *.aux *.log
	rm -rf svg-inkscape

LATEX_OPTS = -shell-escape
FILTER_OUT = $(foreach v,$(2),$(if $(findstring $(1),$(v)),,$(v)))

SCAD_FILES = $(sort $(call FILTER_OUT,symbols,$(wildcard *.scad)))
SVG_FILES = $(subst .scad,.svg,$(SCAD_FILES))

.PHONY: list
list:
	@echo $(SCAD_FILES)
	@echo $(SVG_FILES)

plan.tex: $(SVG_FILES)

%.svg: %.scad
	openscad -o $@ $<

%.pdf: %.tex Makefile 
	pdflatex $(LATEX_OPTS) $<
	pdflatex $(LATEX_OPTS) $<
	pdflatex $(LATEX_OPTS) $<

