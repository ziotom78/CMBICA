NOWEAVE = noweave
NOTANGLE = notangle
NODEFS = nodefs
NOINDEX = noindex
CPIF = cpif
TEXI2PDF = texi2pdf

SOURCE_DIR = src
DOC_DIR = docs

SOURCE_NW = cmbica.nw main-program.nw test.nw whitening.nw fastica.nw masking.nw
SOURCE_IMAGES = mask-sketch.pdf correlation-dmr.pdf correlation-dmr-whitened.pdf
TEX_FILES := $(addprefix $(DOC_DIR)/, $(SOURCE_NW:%.nw=%.tex))
IMAGES := $(addprefix $(DOC_DIR)/, $(SOURCE_IMAGES))
DEFS_FILES := $(SOURCE_NW:%.nw=%.defs)
BIB_FILE = cmbica.bib
INDEX_FILE = all.defs

vpath %.nw $(SOURCE_DIR)

.PHONY: all test

all: $(DOC_DIR)/cmbica.pdf cmbica.py

$(DOC_DIR)/cmbica.pdf: $(TEX_FILES) $(BIB_FILE) $(IMAGES)
	$(TEXI2PDF) --batch --pdf $<
	$(NOINDEX) $<
	$(TEXI2PDF) --batch --pdf $<

cmbica.tex: $(SOURCE_NW) $(BIB_FILE)
	$(NOWEAVE) -n -delay -index $< | $(CPIF) $@

cmbica.py: $(SOURCE_NW)
	$(NOTANGLE) -R$@ $^ | $(CPIF) $@

$(DOC_DIR)/%.pdf: $(DOC_DIR)/%.asy
	asy -f pdf -o $@ $<

$(INDEX_FILE): $(DEFS_FILES)
	sort -u $? | cpif $@

$(TEX_FILES): | $(DOC_DIR)

$(DOC_DIR):
	mkdir $(DOC_DIR)

$(DOC_DIR)/%.tex: %.nw $(INDEX_FILE)
	$(NOWEAVE) -n -delay -indexfrom $(INDEX_FILE) $< | $(CPIF) $@

%.defs: %.nw
	$(NODEFS) $< | cpif $@

test: cmbica.py
	nosetests -v \
	    --with-coverage --cover-package=cmbica \
	    --with-doctest --cover-html $<
