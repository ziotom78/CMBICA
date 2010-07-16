SOURCE_NW = tomica.nw
BIB_FILE = tomica.bib

.phony: all

all: tomica.pdf tomica.py fastica.configspec

tomica.pdf: tomica.tex
	texi2pdf --batch --pdf $<

tomica.tex: $(SOURCE_NW) $(BIB_FILE)
	noweave -n -delay -index $< | cpif $@

tomica.py: $(SOURCE_NW)
	notangle $< | cpif $@
