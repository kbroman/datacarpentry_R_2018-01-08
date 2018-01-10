# ggplot2 lesson

# download portal_clean.csv
download.file("http://kbroman.org/datacarp/portal_clean.csv",
              "../clean_data/portal_clean.csv")

# read in the data
surveys <- read.csv("../clean_data/portal_clean.csv")

# load dplyr
library(dplyr)

# create some datasets
# 1. only the obs with species_id=="DM"
just_dm <- surveys %>% filter(species_id == "DM")
# 2. average weight and hindfoot length and count of each species
stat_summary <- surveys %>% group_by(species_id) %>% 
    summarize(mean_wt=mean(weight),
              mean_hfl=mean(hindfoot_length),
              n=n())
# 3. average wt, hfl, count by year, species, sex
year_summary <- surveys %>% group_by(species_id, year, sex) %>% 
    summarize(mean_wt=mean(weight),
              mean_hfl=mean(hindfoot_length),
              n=n())

# start ggplot2
library(ggplot2)

# make an initial graph
ggplot(surveys, aes(x=weight, y=hindfoot_length)) + geom_point()

# same thing step by step
p1 <- ggplot(surveys, aes(x=weight, y=hindfoot_length))
p2 <- p1 + geom_point()
p1 # prints a blank frame
p2 # prints the full scatterplot

# make x axis on log scale
p2 + scale_x_log10()

# make x axis on sqrt scale
p2 + scale_x_sqrt()

# challenge 1
ggplot(just_dm, aes(x=weight, y=hindfoot_length)) + 
    geom_point()

# blue points
ggplot(just_dm, aes(x=weight, y=hindfoot_length)) + 
    geom_point(color="slateblue")

# small blue points 
ggplot(just_dm, aes(x=weight, y=hindfoot_length)) + 
    geom_point(color="slateblue", size=0.5)

# small blue somewhat transparent points 
ggplot(just_dm, aes(x=weight, y=hindfoot_length)) + 
    geom_point(color="slateblue", size=0.5, alpha=0.1)

# back to the full surveys data 
#    color the points by species
ggplot(surveys, aes(x=weight, y=hindfoot_length)) + 
    geom_point(aes(color=species_id), size=0.5, alpha=0.1)

# challenge 2
ggplot(stat_summary, aes(x=mean_wt, y=mean_hfl)) + 
    geom_point()

# color points by species
ggplot(stat_summary, aes(x=mean_wt, y=mean_hfl)) + 
    geom_point(aes(color=species_id))

# species == shape of point (but there aren't many shapes)
ggplot(stat_summary, aes(x=mean_wt, y=mean_hfl)) + 
    geom_point(aes(shape=species_id))

# species == size of point
ggplot(stat_summary, aes(x=mean_wt, y=mean_hfl)) + 
    geom_point(aes(size=species_id))

# total counts of species each year
yearly_counts <- surveys %>% group_by(year) %>% tally()

# line plot of n vs year
ggplot(yearly_counts, aes(x=year, y=n)) + geom_line()

# do both points and lines
ggplot(yearly_counts, aes(x=year, y=n)) + 
    geom_line() +
    geom_point(color="Orchid")

# do both points and lines, with lines on top
ggplot(yearly_counts, aes(x=year, y=n)) + 
    geom_point(color="Orchid") +
    geom_line()
    
# color of the points change by year
ggplot(yearly_counts, aes(x=year, y=n)) + 
    geom_point(aes(color=year)) +
    geom_line()

# color of everything change by year
ggplot(yearly_counts, aes(x=year, y=n, color=year)) + 
    geom_point() +
    geom_line()

# color of everything change by year
ggplot(yearly_counts, aes(x=year, y=n, color=year)) + 
    geom_point() +
    geom_line()

# another way to do that
ggplot(yearly_counts, aes(x=year, y=n)) + 
    geom_point() +
    geom_line() +
    aes(color=year)

# themes
ggplot(yearly_counts, aes(x=year, y=n)) + 
    geom_point() +
    geom_line() +
    aes(color=year) + theme_bw()

ggplot(yearly_counts, aes(x=year, y=n)) + 
    geom_point() +
    geom_line() +
    aes(color=year) + theme_classic()

# theme karl (need the "broman" package)
ggplot(yearly_counts, aes(x=year, y=n)) + 
    geom_point() +
    geom_line() +
    aes(color=year) + broman::theme_karl()

# challenge 3 
ggplot(year_summary, aes(x=year, y=n)) + 
    geom_line(aes(color=species_id))

# deal with sex problem
ggplot(year_summary, aes(x=year, y=n)) + 
    geom_line(aes(color=species_id, linetype=sex))

# histogram of weights
ggplot(surveys, aes(x=weight)) + geom_histogram()

# use more bins
ggplot(surveys, aes(x=weight)) + geom_histogram(bins=200)

# boxplot
ggplot(surveys, aes(x=species_id, y=weight)) + geom_boxplot()

# boxplot + jittered dot plot
ggplot(surveys, aes(x=species_id, y=weight)) + 
    geom_boxplot() +
    geom_jitter(color="tomato", size=0.5)

# boxplot + jittered dot plot
ggplot(surveys, aes(x=species_id, y=weight)) + 
    geom_jitter(color="tomato", size=0.5, height=0, width=0.2) +
    geom_boxplot()

# faceting on species
ggplot(year_summary, aes(x=year, y=n)) +
    geom_line(aes(color=sex)) +
    facet_wrap(~species_id)

# facet grid
ggplot(year_summary, aes(x=year, y=n)) +
    geom_line(aes(color=species_id)) +
    facet_grid(~sex)

# split vertically
ggplot(year_summary, aes(x=year, y=n)) +
    geom_line(aes(color=species_id)) +
    facet_grid(sex ~ .)

# split both ways
ggplot(year_summary, aes(x=year, y=n)) +
    geom_line() +
    facet_grid(species_id ~ sex)

# filter down to 3 species
year_summary %>% 
 filter(species_id %in% c("DM","DS","DO")) %>% 
 ggplot(aes(x=year, y=n)) +
    geom_line() +
    facet_grid(species_id ~ sex)
