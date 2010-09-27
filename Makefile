NOWEAVE = noweave
NOTANGLE = notangle
CPIF = cpif
TEXI2PDF = texi2pdf
IMAGES = mask-sketch.pdf

SOURCE_NW = cmbica.nw
BIB_FILE = cmbica.bib

.phony: all

all: cmbica.pdf cmbica.py fastica.configspec

cmbica.pdf: cmbica.tex $(IMAGES)
	$(TEXI2PDF) --batch --pdf $<

cmbica.tex: $(SOURCE_NW) $(BIB_FILE)
	$(NOWEAVE) -n -delay -index $< | $(CPIF) $@

cmbica.py: $(SOURCE_NW)
	$(NOTANGLE) $< | $(CPIF) $@

%.pdf: %.asy
	asy -f pdf -o $@ $<
