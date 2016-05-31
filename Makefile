all: pages challenge_slides.html

%.html: %.Rmd
	Rscript -e "rmarkdown::render('$<', output_format=rmarkdown::html_document(toc=TRUE, highlight='tango', self_contained=FALSE, lib_dir='libs'))"

motivation.html: motivation.md
	pandoc -o $@ $^

pages: motivation.html 01-intro-to-R.html 02-data-frames.html 03-dplyr.html 04-ggplot2.html 05-rmarkdown.html capstone.html 01-notes.html 02-notes.html

challenge_slides.Rmd: ruby/make_challenge_slides.rb 01-intro-to-R.Rmd 02-data-frames.Rmd 03-dplyr.Rmd 04-ggplot2.Rmd capstone.Rmd
	$<

challenge_slides.html: challenge_slides.Rmd
	R -e "rmarkdown::render('$<')"

capstone.html: capstone.Rmd
	Rscript -e "rmarkdown::render('$<', output_format=rmarkdown::html_document(highlight='tango', self_contained=FALSE, lib_dir='libs'))"
