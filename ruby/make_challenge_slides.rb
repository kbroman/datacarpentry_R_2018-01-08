#!/usr/bin/env ruby
# grab the challenges from the .Rmd files and make slides

files = ["01-intro-to-R.Rmd"]
ofile = "challenge_slides.Rmd"

output = []

files.each do |file|
    fp = File.open(file)
    fp.each do |line|
        if line =~ /^#+ Challenge$/
            this_output = ''
            while !(fp.eof?)
                line2 = fp.readline()
                if line2 =~ /end challenge/
                    break
                end
                this_output += line2
            end

            output.push(this_output)

        end
    end
end


ofp = File.open(ofile, 'w')
ofp.write("---\n")
ofp.write("output: slidy_presentation\n")

challenge = 1
output.each do |ochunk|
    ofp.write("---\n\n")
    ofp.write("# Challenge #{challenge}\n\n")
    ofp.write(ochunk)
    ofp.write("\n")
    challenge += 1
end
