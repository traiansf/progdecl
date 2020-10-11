all: beamer

beamer: 02-functii.pdf

%.pdf: %.md
	pandoc -t beamer $< -H ../slides-prelude.tex  -o $@

clean:
	rm -f *.pdf