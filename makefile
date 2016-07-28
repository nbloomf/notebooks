all: rings geo badness

rings:
	@echo "Making rings.pdf" | doppler lightgreen
	pdflatex -interaction=batchmode src/ring/rings.tex
	pdflatex -interaction=batchmode src/ring/rings.tex
	makeindex rings
	pdflatex -interaction=batchmode src/ring/rings.tex
	@grep "LaTeX Warning" rings.log | sponge zz-rings-warnings.txt
	@rm rings.aux rings.log rings.toc rings.out
	@rm rings.idx rings.ilg rings.ind
	@find src/ring -name '*.tex' -exec cat {} \; | \
          tex-words.sh | linda.sh | sponge zz-rings-nonwords.txt

geo:
	@echo "Making geo.pdf" | doppler lightgreen
	pdflatex -interaction=batchmode src/geo/geo.tex
	pdflatex -interaction=batchmode src/geo/geo.tex
	makeindex geo
	pdflatex -interaction=batchmode src/geo/geo.tex
	@grep 'LaTeX Warning' geo.log | sponge zz-geo-warnings.txt
	@rm geo.aux geo.log geo.toc geo.out
	@rm geo.idx geo.ilg geo.ind
	@find src/geo -name '*.tex' -exec cat {} \; | \
          tex-words.sh | linda.sh | sponge zz-geo-nonwords.txt

count:
	@find src/ -name '*.tex' -exec cat {} \; | \
          tr -c '$$' ' ' | \
          tr -s '[[:space:]]' '\n' | \
          wc --lines

badness:
	@echo "Finding Badness" | doppler lightgreen
	-@find src/ -name '*.tex' | \
	  xargs grep '\. [[:upper:]]' | sponge zz-sentence-ends.txt
	-@find src/ -name '*.tex' | \
	  xargs grep '\\ref{exerc:' | sponge zz-refs.txt
	-@find src/ -name '*.tex' | \
	  xargs grep '\\ref{sec:' | sponge zz-refs.txt
	-@find src/ -name '*.tex' | \
	  xargs grep '\\ref{chap:' | sponge zz-refs.txt

