help:
	echo "geo, rings"

rings:
	pdflatex -interaction=batchmode src/ring/rings.tex
	pdflatex -interaction=batchmode src/ring/rings.tex
	makeindex rings
	pdflatex -interaction=batchmode src/ring/rings.tex
	grep "LaTeX Warning" rings.log > warnings.txt
	rm rings.aux rings.log rings.toc rings.out
	rm rings.idx rings.ilg rings.ind

geo:
	pdflatex -interaction=batchmode src/geo/geo.tex
	pdflatex -interaction=batchmode src/geo/geo.tex
	makeindex geo
	pdflatex -interaction=batchmode src/geo/geo.tex
	rm geo.aux geo.log geo.toc geo.out
	rm geo.idx geo.ilg geo.ind

spell:
	tools/texwords.sh src/ring/rings.tex > nonwords.txt

count:
	tools/countcash.sh src/ring/rings.tex
	tools/countcash.sh src/geo/geo.tex
