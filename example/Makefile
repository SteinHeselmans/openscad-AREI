
.PHONY: all
all: plan.pdf

.PHONY: clean
clean:
	rm -f *.svg *.pdf *.pdf_tex *.aux *.log

FILTER_OUT = $(foreach v,$(2),$(if $(findstring $(1),$(v)),,$(v)))

SCAD_FILES = $(sort $(call FILTER_OUT,symbols,$(wildcard *.scad)))
PDF_TEX_FILES = $(subst .scad,.pdf_tex,$(SCAD_FILES))

.PHONY: list
list:
	@echo $(SCAD_FILES)
	@echo $(PDF_TEX_FILES)

plan.tex: $(PDF_TEX_FILES)

%.pdf_tex: %.svg
	inkscape -D -z --file=$< --export-pdf=$(subst _tex,,$@) --export-latex

%.svg: %.scad
	openscad -o $@ $<

%.pdf: %.tex
	pdflatex $<
	pdflatex $<
	pdflatex $<

