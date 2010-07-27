NOWEAVE = noweave
NOTANGLE = notangle
CPIF = cpif
TEXI2PDF = texi2pdf

SOURCE_NW = tomica.nw
BIB_FILE = tomica.bib

.phony: all

all: tomica.pdf tomica.py fastica.configspec

tomica.pdf: tomica.tex
	$(TEXI2PDF) --batch --pdf $<

tomica.tex: $(SOURCE_NW) $(BIB_FILE)
	$(NOWEAVE) -n -delay -index $< | $(CPIF) $@

tomica.py: $(SOURCE_NW)
	$(NOTANGLE) $< | $(CPIF) $@
