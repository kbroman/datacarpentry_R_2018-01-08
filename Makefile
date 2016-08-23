all: pages challenge_slides.html capstone_soln/capstone_soln.html

%.html: %.Rmd
	Rscript -e "rmarkdown::render('$<', output_format=rmarkdown::html_document(toc=TRUE, highlight='tango', self_contained=FALSE, lib_dir='libs'))"

motivation.html: motivation.md
	pandoc -o $@ $^

pages: motivation.html 01-intro-to-R.html 02-dplyr.html 03-ggplot2.html 04-rmarkdown.html capstone.html 01-notes.html 02-notes.html 03-notes.html

challenge_slides.Rmd: ruby/make_challenge_slides.rb 01-intro-to-R.Rmd 02-dplyr.Rmd 03-ggplot2.Rmd 04-rmarkdown.Rmd capstone.Rmd
	$<

challenge_slides.html: challenge_slides.Rmd
	R -e "rmarkdown::render('$<')"

capstone.html: capstone.Rmd
	Rscript -e "rmarkdown::render('$<', output_format=rmarkdown::html_document(highlight='tango', self_contained=FALSE, lib_dir='libs'))"

capstone_soln/capstone_soln.html: capstone_soln/capstone_soln.Rmd
	R -e "rmarkdown::render('$<')"
