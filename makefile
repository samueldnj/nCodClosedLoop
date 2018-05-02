export PATH := /Library/TeX/texbin:$(PATH)    # add LaTeX path
export PATH := /usr/local/bin:~/.local/bin:$(PATH) # add pandoc-citeproc-preamble

# Cluster targets
all:  pdf doc
#pdf:  appendix.tex nCodClosedLoop.pdf TandF.pdf
pdf:  nCodClosedLoop.pdf 
#TandF.pdf	
doc:  nCodClosedLoop.docx

# Variables for pandoc calls
PANDOC = pandoc
LATEX = pdflatex
BIB  = --bibliography=/Users/sdnjohnson/Work/Library/library.bib 
# ~ replaces Users/beaudoherty

CSL  = --csl=/Users/sdnjohnson/Work/write/templates/csl/cjfas.csl 
# CSL repository https://github.com/citation-style-language/styles

PTMP = --template=/Users/sdnjohnson/Work/write/templates/tex/basic.latex
NOPRETMP = --template=/Users/sdnjohnson/Work/write/templates/tex/noPreamble.latex
# BIBPRE = --filter pandoc-citeproc-preamble -M citeproc-preamble=/Users/sdnjohnson/Work/write/templates/tex/citeproc-preamble.latex 
EQNO = --filter pandoc-eqnos

ABV  = --citation-abbreviations=/Users/sdnjohnson/Work/write/templates/csl/csl-abbrev/jabbrev.json
# STMP = --template ./pandoc/sup.latex
# FTMP = --template ./pandoc/fig.latex
FONT = --variable fontsize=12pt
TIMS = --variable mainfont=Times
WTMP = --reference-docx=/Users/sdnjohnson/Work/write/templates/docx/basic.docx

# Can create word doc with formatting want and save for template for this

## pdf
nCodClosedLoop.pdf: nCodClosedLoop.tex makefile
	$(LATEX) $<

## tex
nCodClosedLoop.tex: nCodClosedLoop.md makefile
	$(PANDOC) -s $(PTMP) $(BIB) $(EQNO) $(ABV) $(CSL) $(FONT) $(TIMS) -o $@ $<

## docx
nCodClosedLoop.docx: nCodClosedLoop.tex makefile
	$(PANDOC) -s -S $(WTMP) -o $@ $<

## appendix.tex
# appendix.tex: appendix.md makefiles
# 	$(PANDOC) -s $(NOPRETMP) $(ABV) $(BIB) $(BIBPRE) $(CSL) $(FONT) $(TIMS) -o $@ $<

# TandF
TandF.pdf: TandF.tex makefile
	$(LATEX) $<

TandF.tex: TandF.md makefile
	$(PANDOC) -s -S $(PTMP) -o $@ $<	

## cleanup
clean:
	rm -f *.{pdf,doc,docx,tex,aux,log,out,toc}
