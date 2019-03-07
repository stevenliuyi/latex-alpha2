#!/bin/bash

FILENAME=$1
docker pull stevenliuyi/latexalpha2
docker run -dit --name latexalpha2 stevenliuyi/latexalpha2
docker cp $FILENAME.tex latexalpha2:/latexalpha2
docker exec latexalpha2 pdflatex -shell-escape $FILENAME.tex
docker exec latexalpha2 sh -c "asy $FILENAME-*.asy"
docker exec latexalpha2 pdflatex -shell-escape $FILENAME.tex
docker cp latexalpha2:/latexalpha2/$FILENAME.pdf .
docker stop latexalpha2
docker rm latexalpha2
