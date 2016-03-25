#
# Makefile
# matael, 2016-03-05 20:19
#

PROJECT=main
LATEX_OPTIONS=-interaction=nonstopmode

all:
		xelatex $(LATEX_OPTIONS) $(PROJECT).tex
		biber $(PROJECT)
		xelatex $(LATEX_OPTIONS) $(PROJECT).tex
		xelatex $(LATEX_OPTIONS) $(PROJECT).tex

clean:
		rm *.aux *.log *.bcf *.bbl *.blg *.log *.pdf *.run.xml
