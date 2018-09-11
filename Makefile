.PHONY:	clean clean-html all check deploy debug

XSLTPROC = xsltproc --timing --stringparam debug.datedfiles no # -v

MATHBOOK_ROOT = ../mathbook/ # TODO implement this everywhere

docs/:	docs/buntes.pdf buntes-pretty.xml buntes.xsl filter.xsl
	mkdir -p docs
	cd docs/; \
	$(XSLTPROC) ../buntes.xsl ../buntes-pretty.xml

buntes.tex:	buntes-pretty.xml buntes-latex.xsl filter.xsl
	$(XSLTPROC) buntes-latex.xsl buntes-pretty.xml

buntes.md:	buntes-pretty.xml filter.xsl
	$(XSLTPROC) ../mathbook/xsl/mathbook-markdown-common.xsl buntes-wrapper.xml > buntes.md

docs/buntes.pdf:	buntes.tex
	latexmk -pdf -output-directory=docs -pdflatex="pdflatex -interaction=nonstopmode"  buntes.tex

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
	jing ../mathbook/schema/pretext.rng buntes-pretty.xml
	#xmllint --xinclude --postvalid --noout --dtdvalid ../mathbook/schema/dtd/mathbook.dtd buntes-pretty.xml
	$(XSLTPROC) ../mathbook/schema/pretext-schematron.xsl buntes-pretty.xml

clean-html:
	rm -rf docs

clean:	clean-html
	rm -f buntes.md
	rm -f buntes*.tex
	rm -f buntes*.xml

docs/images/:	docs buntes-wrapper.xml
	mkdir -p docs/images
	../mathbook/script/mbx -vv -c latex-image -f svg -d ~/buntes/docs/images ~/buntes/buntes-wrapper.xml
