
.PHONY: all clean

BASENAME=presentation
TARGETS=out/$(BASENAME).pdf

# http://stackoverflow.com/questions/18136918/how-to-get-current-directory-of-your-makefile
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

OUT_DIR = out
DEPS_DIR = out/deps
LATEXMK = latexmk -recorder -use-make -deps
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

out/%.pdf : %.tex $(DEPS_DIR)/.touch $(OUT_DIR)/.touch out/$(BASENAME)preamble.fmt
	TEXINPUTS=.:$(ROOT_DIR)/mtheme/: $(LATEXMK) -pdf -dvi- -ps- -output-directory=out -pdflatex="xelatex -fmt $(BASENAME)preamble.fmt -shell-escape %O %S" -deps-out=$(DEPS_DIR)/$(notdir $@)P $<

# Dump presentation preamble as a fmt file
out/$(BASENAME)preamble.fmt: $(OUT_DIR)/.touch $(BASENAME)preamble.tex
	TEXINPUTS=.:$(ROOT_DIR)/mtheme/: xelatex -ini -shell-escape -jobname="$(BASENAME)preamble" -output-directory=out "&xelatex $(BASENAME)preamble.tex\dump"

clean:
	latexmk -C -output-directory=out $(BASENAME).tex
