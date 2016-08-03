all: rings geo badness

rings:
	@echo "Making rings.pdf" | doppler lightgreen
	@pdflatex -file-line-error -interaction=batchmode src/ring/rings.tex > /dev/null
	@pdflatex -file-line-error -interaction=batchmode src/ring/rings.tex > /dev/null
	@makeindex -q rings
	@pdflatex -file-line-error -interaction=batchmode src/ring/rings.tex > /dev/null
	@echo "  Saving warnings" | doppler lightblue
	@grep "LaTeX Warning" rings.log | sponge zz-rings-warnings.txt
	@[ -s zz-rings-warnings.txt ] || rm zz-rings-warnings.txt
	@echo "  Cleaning up" | doppler lightblue
	@rm rings.aux rings.log rings.toc rings.out
	@rm rings.idx rings.ilg rings.ind

geo:
	@echo "Making geo.pdf" | doppler lightgreen
	@pdflatex -file-line-error -interaction=batchmode src/geo/geo.tex > /dev/null
	@pdflatex -file-line-error -interaction=batchmode src/geo/geo.tex > /dev/null
	@makeindex -q geo
	@pdflatex -file-line-error -interaction=batchmode src/geo/geo.tex > /dev/null
	@echo "  Saving warnings" | doppler lightblue
	@grep 'LaTeX Warning' geo.log | sponge zz-geo-warnings.txt
	@[ -s zz-geo-warnings.txt ] || rm zz-geo-warnings.txt
	@echo "  Cleaning up" | doppler lightblue
	@rm geo.aux geo.log geo.toc geo.out
	@rm geo.idx geo.ilg geo.ind

count:
	@find src/ -name '*.tex' -exec cat {} \; | \
          tr -c '$$' ' ' | \
          tr -s '[[:space:]]' '\n' | \
          wc --lines

words:
	-@find src/ring -name '*.tex' -exec cat {} \; | \
	  tex-words.sh | sponge zz-rings-nonwords.txt
	@[ -s zz-rings-nonwords.txt ] || rm zz-rings-nonwords.txt
	-@find src/geo -name '*.tex' -exec cat {} \; | \
	  tex-words.sh | sponge zz-geo-nonwords.txt
	@[ -s zz-geo-nonwords.txt ] || rm zz-geo-nonwords.txt

badness:
	@echo "Finding Badness" | doppler lightgreen
	@ #
	@ #
	@ #
	@echo "  Unknown words" | doppler lightblue
	-@find src/ring -name '*.tex' -exec cat {} \; | \
	  tex-words.sh | linda.sh | sponge zz-rings-nonwords.txt
	@[ -s zz-rings-nonwords.txt ] || rm zz-rings-nonwords.txt
	-@find src/geo -name '*.tex' -exec cat {} \; | \
	  tex-words.sh | linda.sh | sponge zz-geo-nonwords.txt
	@[ -s zz-geo-nonwords.txt ] || rm zz-geo-nonwords.txt
	@ #
	@ #
	@ #
	@echo "  >1 sentence per line" | doppler lightblue
	-@find src/ -name '*.tex' | \
	  xargs grep '\. [[:upper:]]' | sponge zz-sentence-ends.txt
	@[ -s zz-sentence-ends.txt ] || rm zz-sentence-ends.txt
	@ #
	@ #
	@ #
	@echo "  Bad references" | doppler lightblue
	-@find src/ -name '*.tex' | \
	  xargs grep '\\ref{exerc:' | sponge zz-erefs.txt
	@[ -s zz-erefs.txt ] || rm zz-erefs.txt
	-@find src/ -name '*.tex' | \
	  xargs grep '\\ref{sec:' | sponge zz-srefs.txt
	@[ -s zz-srefs.txt ] || rm zz-srefs.txt
	-@find src/ -name '*.tex' | \
	  xargs grep '\\ref{chap:' | sponge zz-crefs.txt
	@[ -s zz-crefs.txt ] || rm zz-crefs.txt
	@ #
	@ #
	@ #
	@echo "  Index entries" | doppler lightblue
	-@find src/ -name '*.tex' | \
	  xargs grep '[^}]\\index{' | sponge zz-index.txt
	@[ -s zz-index.txt ] || rm zz-index.txt
