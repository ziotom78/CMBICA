NOWEAVE = noweave
NOTANGLE = notangle
NODEFS = nodefs
NOINDEX = noindex
CPIF = cpif
TEXI2PDF = texi2pdf
IMAGES = mask-sketch.pdf

SOURCE_DIR = src

SOURCE_NW = cmbica.nw main-program.nw test.nw whitening.nw fastica.nw masking.nw
TEX_FILES = $(SOURCE_NW:%.nw=%.tex)
DEFS_FILES = $(SOURCE_NW:%.nw=%.defs)
BIB_FILE = cmbica.bib
INDEX_FILE = all.defs

vpath %.nw $(SOURCE_DIR)

.PHONY: all test

all: cmbica.pdf cmbica.py

cmbica.pdf: $(TEX_FILES) $(BIB_FILE) $(IMAGES)
	$(TEXI2PDF) --batch --pdf $<
	$(NOINDEX) $<
	$(TEXI2PDF) --batch --pdf $<

cmbica.tex: $(SOURCE_NW) $(BIB_FILE)
	$(NOWEAVE) -n -delay -index $< | $(CPIF) $@

cmbica.py: $(SOURCE_NW)
	$(NOTANGLE) -R$@ $^ | $(CPIF) $@

%.pdf: %.asy
	asy -f pdf -o $@ $<

$(INDEX_FILE): $(DEFS_FILES)
	sort -u $? | cpif $@

%.tex: %.nw $(INDEX_FILE)
	$(NOWEAVE) -n -delay -indexfrom $(INDEX_FILE) $< | $(CPIF) $@

%.defs: %.nw
	$(NODEFS) $< | cpif $@

test: cmbica.py
	nosetests -v \
	    --with-coverage --cover-package=cmbica \
	    --with-doctest $<
