# data visualization

# load "reduced" data
reduced <- read.csv("http://kbroman.org/datacarp/portal_data_reduced.csv")

# load dplyr and ggplot2
library(dplyr)
library(ggplot2)

# scatterplot of hindfoot length vs weight
ggplot(reduced, aes(x = weight, y=hindfoot_length)) +
    geom_point()

# another way 
p1 <- ggplot(reduced, aes(x=weight, y=hindfoot_length))
p2 <- p1 + geom_point()
p2

# can use pipe
reduced %>% ggplot(aes(x = weight, y=hindfoot_length)) +
    geom_point()

# put x-axis on log scale
p2 + scale_x_log10()
p2 + scale_x_sqrt()

# challenge 10
reduced %>% filter(species_id == "DM") %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point()

# other aesthetics
surveys_plot <- ggplot(reduced, aes(x=weight, y=hindfoot_length))
surveys_plot + geom_point(alpha=0.1)
surveys_plot + geom_point(color="slateblue")
surveys_plot + geom_point(size=0.5)
surveys_plot + geom_point(aes(color=species_id))

# challenge 11
data_to_plot <- reduced %>% group_by(species_id) %>% 
    summarize(mean_weight=mean(weight),
              mean_hfl=mean(hindfoot_length),
              sample_size=n())

ggplot(data_to_plot, aes(x=mean_weight, y=mean_hfl)) +
    geom_point(aes(size = sample_size))

# could do this
ggplot(data_to_plot, aes(x=mean_weight, y=mean_hfl, size = sample_size)) +
    geom_point()

ggplot(data_to_plot) +
    geom_point(aes(x=mean_weight, y=mean_hfl, size = sample_size))

# plot counts of observations by year
count_by_year <- reduced %>% group_by(year) %>% 
    tally()

# basic plot object
p <- ggplot(count_by_year, aes(x=year, y=n))
# line plot
p + geom_line()

# both points and lines
p + geom_line(color="#400060") + geom_point(color="slateblue")
p + geom_line(color="violetred") + geom_point(color="slateblue")
p + geom_point(color="slateblue") + geom_line(color="violetred")
p + geom_point(aes(color=year)) + geom_line()
p + geom_point(aes(color=year)) + geom_line(aes(color=year))
p + geom_point() + geom_line() + aes(color=year)

ggplot(count_by_year, aes(x=year, y=n)) +
    geom_point() + geom_line() + aes(color=year)

ch12 <- reduced %>% filter(species_id %in% c("DM", "DS")) %>% 
    group_by(year, species_id) %>% tally()

ggplot(ch12, aes(x=year, y=n)) + geom_point() +
    geom_line() + aes(color=species_id)

ggplot(ch12, aes(x=year, y=n)) + geom_point(aes(color=species_id)) +
    geom_line(aes(group=species_id)) 

ggplot(ch12, aes(x=year, y=n)) + geom_point(aes(color=species_id)) +
    geom_line(aes(color=species_id)) 

ggplot(ch12, aes(x=year, y=n)) + 
    geom_line(aes(group=species_id)) +
    geom_point(aes(color=species_id))

# histogram
ggplot(reduced, aes(x=weight)) + geom_histogram()

ggplot(reduced, aes(x=weight)) + geom_histogram(bins=300)

# boxplot
ggplot(reduced, aes(x=species_id, y=hindfoot_length)) +
    geom_boxplot()

# violin plot
ggplot(reduced, aes(x=species_id, y=hindfoot_length)) +
    geom_violin()

# faceting
yearly_counts <- reduced %>% group_by(year, species_id) %>% tally()
ggplot(yearly_counts, aes(x=year, y=n, group=species_id, color=species_id)) +
    geom_line() + facet_wrap( ~ species_id)

# yearly weights by sex for selected species
yearly_weight <- reduced %>% 
    filter(species_id %in% c("DM", "DS", "DO")) %>% 
    group_by(year, species_id, sex) %>% 
        summarize(mean_weight = mean(weight))

# facet grid to split horizontally
ggplot(yearly_weight, aes(x=year, y=mean_weight, color=species_id, group=species_id)) +
      geom_line() + facet_grid(~ sex)

# facet grid to split vertically
ggplot(yearly_weight, aes(x=year, y=mean_weight, color=species_id, group=species_id)) +
    geom_line() + facet_grid(sex ~ .)

# facet grid to split both ways using two variables
ggplot(yearly_weight, aes(x=year, y=mean_weight, color=species_id, group=species_id)) +
    geom_line() + facet_grid(sex ~ species_id)

# saving plots
p <- ggplot(reduced, aes(x=weight, y=hindfoot_length)) + 
    geom_point()
ggsave("hfl_vs_wt.jpg", p)
ggsave("hfl_vs_wt.png", p)
ggsave("hfl_vs_wt.pdf", p, height=7.5, width=10)
