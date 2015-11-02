
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

results/0013_0000000060_%-small.png: results/0013_0000000060_%.png
	convert -crop 300x120+450+150 $< $@

results/0009_0000000060_%-small.png: results/0009_0000000060_%.png
	convert -crop 600x180+0+150 $< $@

cvpr2016AuthorKit/latex/cvpr.sty:
	wget http://www.pamitc.org/cvpr16/files/cvpr2016AuthorKit.tgz -O - | tar xzvf -

out/%.pdf : %.tex $(DEPS_DIR)/.touch $(OUT_DIR)/.touch cvpr2016AuthorKit/latex/cvpr.sty
	TEXINPUTS=cvpr2016AuthorKit/latex/: $(LATEXMK) -pdf -dvi- -ps- -output-directory=out -pdflatex="$(PDFLATEX)" -deps-out=$(DEPS_DIR)/$(notdir $@)P $<

clean:
	latexmk -C -output-directory=out
