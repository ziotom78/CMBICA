NOWEAVE = noweave
NOTANGLE = notangle
CPIF = cpif
TEXI2PDF = texi2pdf
IMAGES = mask-sketch.pdf

SOURCE_NW = cmbica.nw fastica.nw main-program.nw masking.nw whitening.nw
TEX_FILES = $(SOURCE_NW:%.nw=%.tex)
DEFS_FILES = $(SOURCE_NW:%.nw=%.defs)
BIB_FILE = cmbica.bib
INDEX_FILE = all.defs

.phony: all

all: cmbica.pdf cmbica.py

cmbica.pdf: $(TEX_FILES) $(BIB_FILE) $(IMAGES)
	pdflatex -interaction=batchmode $<
	noindex $<
	$(TEXI2PDF) --batch --pdf $<

cmbica.tex: $(SOURCE_NW) $(BIB_FILE)
	$(NOWEAVE) -n -delay -index $< | $(CPIF) $@

cmbica.py: $(SOURCE_NW)
	$(NOTANGLE) $< | $(CPIF) $@

%.pdf: %.asy
	asy -f pdf -o $@ $<

$(INDEX_FILE): $(DEFS_FILES)
	sort -u $? | cpif $@

%.tex: %.nw $(INDEX_FILE)
	noweave -n -delay -indexfrom $(INDEX_FILE) $< | cpif $@

%.defs: %.nw
	nodefs $< | cpif $@
