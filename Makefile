.PHONY:	clean clean-html all check deploy debug

XSLTPROC = xsltproc --timing --stringparam debug.datedfiles no --stringparam html.google-classic UA-48250536-1 # -v

MATHBOOK_ROOT = ../pretext # TODO implement this everywhere

docs/:	docs/buntes.pdf buntes-pretty.xml buntes.xsl filter.xsl index.html buntes.css
	mkdir -p docs
	cd docs/; \
	$(XSLTPROC) ../buntes.xsl ../buntes-pretty.xml
	cp courbes-semi-stables.pdf docs/
	cp index.html docs/
	cp -r notes docs/
	cp buntes.css docs/

buntes.tex:	buntes-pretty.xml buntes-latex.xsl filter.xsl
	$(XSLTPROC) -o buntes.tex buntes-latex.xsl buntes-pretty.xml

docs/buntes.pdf:	buntes.tex
	cd docs/ && latexmk -pdf -pdflatex="pdflatex --shell-escape -interaction=nonstopmode"  ../buntes.tex

docs/images/:	docs buntes-wrapper.xml
	mkdir -p docs/images
	$(MATHBOOK_ROOT)/script/mbx -vv -c latex-image -f svg -d ~/buntes/docs/images ~/buntes/buntes-wrapper.xml

buntes-wrapper.xml:	*.pug pug-plugin.json
	pug -O pug-plugin.json --extension xml buntes-wrapper.pug
	sed -i.bak -e 's/proofcase/case/g' buntes-wrapper.xml # Fix proofcase->case !! UGLY HACK, SAD
	rm buntes-wrapper.xml.bak

buntes-pretty.xml: buntes-wrapper.xml
	xmllint --pretty 2 buntes-wrapper.xml > buntes-pretty.xml

all:	docs docs/buntes.pdf

deploy: clean-html buntes-wrapper.xml docs
	cp buntes-wrapper.xml docs/buntes.xml
	./deploy.sh

debug:	*.pug pug-plugin.json
	pug -O pug-plugin.json --pretty --extension xml buntes-wrapper.pug

check:	buntes-pretty.xml
	jing $(MATHBOOK_ROOT)/schema/pretext.rng buntes-pretty.xml
	#xmllint --xinclude --postvalid --noout --dtdvalid $(MATHBOOK_ROOT)/schema/dtd/mathbook.dtd buntes-pretty.xml
	$(XSLTPROC) $(MATHBOOK_ROOT)/schema/pretext-schematron.xsl buntes-pretty.xml

clean-html:
	rm -rf docs

clean:	clean-html
	rm -f buntes.md
	rm -f buntes*.tex
	rm -f buntes*.xml

