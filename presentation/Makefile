
TARGETS=out/presentation.pdf

DEPS_DIR = out/deps
LATEXMK = latexmk -recorder -use-make -deps \
	  -e 'warn qq(In Makefile, turn off custom dependencies0);' \
	  -e '@cus_dep_list = ();' \
	  -e 'show_cus_dep();'
all : $(TARGETS)

# Include the dependency makefile produced by latexmk
# latexmk -deps-out= is used to record the dependencies
$(foreach file,$(TARGETS),$(eval -include $(DEPS_DIR)/$(notdir file)P))

$(DEPS_DIR) :
	mkdir $@

out/%.pdf : %.tex
	if [ ! -e $(DEPS_DIR) ]; then mkdir -p $(DEPS_DIR); fi
	$(LATEXMK) -pdf -dvi- -ps- -deps-out=$(DEPS_DIR)/$(notdir $@)P $<

# Dump presentation preamble as a fmt file
out/presentationpreamble.fmt: presentationpreamble.tex
	xelatex -ini -jobname="presentationpreamble" -output-directory=out "&xelatex presentationpreamble.tex\dump"
