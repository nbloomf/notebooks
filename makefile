help:
	echo "geo, rings"

rings:
	pdflatex -interaction=batchmode src/ring/rings.tex
	pdflatex -interaction=batchmode src/ring/rings.tex
	makeindex rings
	pdflatex -interaction=batchmode src/ring/rings.tex
	@grep "LaTeX Warning" rings.log &> rings-warnings.txt
	@rm rings.aux rings.log rings.toc rings.out
	@rm rings.idx rings.ilg rings.ind
	@find src/ring -name '*.tex' -exec cat {} \; | \
          tex-words.sh | linda.sh > nonwords.txt

geo:
	pdflatex -interaction=batchmode src/geo/geo.tex
	pdflatex -interaction=batchmode src/geo/geo.tex
	makeindex geo
	pdflatex -interaction=batchmode src/geo/geo.tex
	@grep 'LaTeX Warning' geo.log &> geo-warnings.txt
	@rm geo.aux geo.log geo.toc geo.out
	@rm geo.idx geo.ilg geo.ind
	@find src/geo -name '*.tex' -exec cat {} \; | \
          tex-words.sh | linda.sh > nonwords.txt

count:
	@find src/ -name '*.tex' -exec cat {} \; | \
          tr -c '$$' ' ' | \
          tr -s '[[:space:]]' '\n' | \
          wc --lines
