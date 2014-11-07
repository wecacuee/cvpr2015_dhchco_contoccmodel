.PHONY: all clean view

LATEXCMD=latexmk -pdf -pdflatex="pdflatex -interactive=nonstopmode" -use-make
all: model.pdf 
#densecrf.pdf presentation.pdf

view: model.pdf
	xdg-open $< 2>/dev/null&

presentation.pdf: presentation.tex graphics/61.png graphics/61WithGraphicalModel.pdf graphics/graphicalModelFrom61.pdf graphics/graphicalModelFrom61ConstVars.pdf graphics/graphicalModelFrom61withConstNodes.pdf graphics/graphicalModelFrom61withConstNodesDirections.pdf model.bib
	$(LATEXCMD) $< model.bib

model.pdf: model.tex model.bib graphics/maxFacesVisible.pdf graphics/ourGraphicalModel2.pdf
	$(LATEXCMD) $< model.bib

densecrf.pdf: densecrf.tex densecrf.bib graphics/gaussianLinear1D.png graphics/gaussian2D.png
	$(LATEXCMD) $<

graphics/%.pdf: graphics/%.svg
	inkscape $< --export-pdf=$@

graphics/gaussianLinear1D.png: plot_linear_and_real_gaussian.py
	python plot_linear_and_real_gaussian.py $@

graphics/gaussian2D.png: plot_linear_and_real_gaussian.py
	python plot_linear_and_real_gaussian.py $@

plot_linear_and_real_gaussian.py:

graphics/61.png:

clean:
	latexmk -CA
