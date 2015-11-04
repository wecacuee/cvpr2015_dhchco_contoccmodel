
.PHONY: all clean

BASENAME=continuousocclusion
TARGETS=out/$(BASENAME).pdf

# http://stackoverflow.com/questions/18136918/how-to-get-current-directory-of-your-makefile
ROOT_DIR:=$(dir $(realpath $(lastword $(MAKEFILE_LIST))))

OUT_DIR = out
DEPS_DIR = out/deps
LATEXMK = latexmk -recorder -use-make -deps
PDFLATEX=pdflatex# -interaction=nonstopmode

all : $(TARGETS)

# Include the dependency makefile produced by latexmk
# latexmk -deps-out= is used to record the dependencies
$(foreach file,$(TARGETS),$(eval -include $(DEPS_DIR)/$(notdir file)P))


$(OUT_DIR)/.touch:
	mkdir -p $(dir $@) 
	touch $@

$(DEPS_DIR)/.touch:
	mkdir -p $(dir $@)
	touch $@

ROOT_OUT_DIR:=/home/vikasdhi/out/sceneunderstanding/results/02-Nov-2015/

results/0013_0000000060_%.png: 	$(ROOT_OUT_DIR)/Visualization/City/2011_09_26_drive_0013/single_window_stepWiseInference/0000000060_%.png
	cp $< $@

results/0009_0000000060_%.png: 	$(ROOT_OUT_DIR)/Visualization/City/2011_09_26_drive_0009/single_window_stepWiseInference/0000000060_%.png
	cp $< $@

results/plotPtransmission_%: $(ROOT_OUT_DIR)/plotPtransmission_%
	cp $< $@

results/plotPtransmission_exact_vs_approx_pt_vis-small.png: results/plotPtransmission_exact_vs_approx_pt_vis.png
	convert -crop 300x110+600+170 $< $@

results/0013_0000000060_%-small.png: results/0013_0000000060_%.png
	convert -crop 300x120+450+150 $< $@

results/0009_0000000060_%-small.png: results/0009_0000000060_%.png
	convert -crop 600x180+0+150 $< $@

cvprlatexdir:= cvpr2016AuthorKit/latex
$(cvprlatexdir)/cvpr.sty $(cvprlatexdir)/eso-pic.sty.bak ieee.bst:
	wget http://www.pamitc.org/cvpr16/files/cvpr2016AuthorKit.tgz -O - | tar xzvf -
	mv $(cvprlatexdir)/eso-pic.sty $(cvprlatexdir)/eso-pic.sty.bak
	ln -sf $(cvprlatexdir)/ieee.bst

out/%.pdf : %.tex $(DEPS_DIR)/.touch $(OUT_DIR)/.touch $(cvprlatexdir)/cvpr.sty $(wildcard Source/*.tex)
	TEXINPUTS=$(cvprlatexdir)/: $(LATEXMK) -pdf -dvi- -ps- -output-directory=out -pdflatex="$(PDFLATEX)" -deps-out=$(DEPS_DIR)/$(notdir $@)P $<

clean:
	latexmk -C -output-directory=out
