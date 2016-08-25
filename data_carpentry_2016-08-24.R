# R intro script

# a calculation
2016 - 1969

# load data from web
surveys <- read.csv("http://kbroman.org/datacarp/portal_data_joined.csv")

# top few rows
head( surveys ) 

# last few rows
tail( surveys )

# structure
str(surveys)

# summary
summary(surveys)

# other useful summaries
dim(surveys)
ncol(surveys)
nrow(surveys)
names(surveys)
colnames(surveys)
rownames(surveys)

# download file from web as local file
download.file("http://kbroman.org/datacarp/portal_data_joined.csv",
              "CleanData/portal_data_joined.csv")

# read data from local file
surveys <- read.csv("CleanData/portal_data_joined.csv")

# current working directory
getwd()

# indexing
surveys[1, 1]
surveys[1, 7]
surveys[10001, 7]
surveys[2, ]
surveys[2,]  # don't _need_ the spaces
surveys[,7]

sex <- surveys[,7]
sex <- surveys[, "sex"]
sex <- surveys$sex
sex <- surveys[["sex"]] 

# pull out a single value from a vector
sex[1]
sex[10001]

# create a vector
c(1, 4, 6)

# pull out multiple values
sex[c(1,4,6)] # <- ouch, 4 and 6 are "" and aren't seen

sex[c(1, 10001)] # <- pull out 1st and 10001th.

# more ways to create vectors 
1:10
10:1
sex[1:10]

# every 2nd value
seq(1, 10, by=2)
sex[seq(1,10, by=2)]

# first ten rows of surveys
surveys[1:3,]
surveys[10001:10003,]
surveys[5:7, 1:7]


# seq function
seq(1, 11)
?seq # help
seq(1, 11, 2)
seq(1, 11, by=2)
seq(to=11, from=1, by=2) 

# challenge # 2
nrow(surveys)
indexes <- seq(10, nrow(surveys), by=10)
surveys_by_10 <- surveys[indexes ,  ]

surveys_by_10 <- surveys[seq(10, nrow(surveys), by=10),  ]

# those awful blanks in the data file
surveys <- read.csv("CleanData/portal_data_joined.csv", 
                    na.strings="")

surveys[,"sex"]

### dplyr

# install packages
install.packages("dplyr")
install.packages("ggplot2")

# load the dplyr package
library(dplyr)

# select some columns
selected_col <- select(surveys, sex, species_id, plot_type, weight)
head(selected_col)

# filter out some rows
selected_row <- filter(surveys, year == 2002)
head(selected_row)

# filter out some rows
selected_row <- filter(surveys, year == 2002, weight>78)
head(selected_row)

selected_row <- filter(surveys, sex == "F", weight>78)
head(selected_row)

# pipe operator
surveys %>% 
    filter(weight < 5) %>% 
    select(species_id, sex, weight)
 
selected_rows <- filter(surveys, weight<5)
result <- select(selected_rows, species_id, sex, weight)

# challenge #4
surveys %>% 
    filter(year < 1995) %>% 
    select(year, sex, weight)

# variation on that, also filter on weight
surveys %>% 
    filter(year < 1995) %>% 
    filter(weight > 78) %>% 
    select(year, sex, weight)

# equivalent to that
surveys %>% 
    filter(year < 1995, weight > 78) %>% 
    select(year, sex, weight)

# also filter on species_id
selected_stuff <- surveys %>% 
    filter(year < 1995, weight > 78, species_id=="DM") %>% 
    select(year, sex, weight)

# you can actually do this
# (but please don't)
surveys %>% 
    filter(year < 1995, weight > 78, species_id=="DM") %>% 
    select(year, sex, weight) -> selected_stuff

# mutate 
surveys %>% 
    mutate(weight_kg = weight / 1000) %>% 
    tail()

# mutate + filter
surveys %>% 
    filter(weight > 78) %>% 
    mutate(weight_kg = weight / 1000) %>% 
    tail()

# mutate + filter + select
surveys %>% 
    filter(weight > 78) %>% 
    mutate(weight_kg = weight / 1000) %>% 
    select(weight, weight_kg) %>% 
    tail()

# this won't work
surveys %>% 
    filter(weight > 78) %>% 
    select(weight, weight_kg) %>% 
    mutate(weight_kg = weight / 1000) %>% 
    tail()

surveys_plus_weight_kg <- surveys %>% 
    filter(weight > 78) %>% 
    mutate(weight_kg = weight / 1000)

# add column and write over the surveys data
surveys <- surveys %>% 
    mutate(weight_kg = weight / 1000)

# square-root function
sqrt(5)

# challenge 5
result <- surveys %>% 
    mutate(hindfoot_sqrt=sqrt(hindfoot_length)) %>% 
    filter(hindfoot_sqrt < 3) %>% 
    select(species_id, hindfoot_sqrt)
    
# variation on challenge 5, saving rows with NAs
result2 <- surveys %>% 
    mutate(hindfoot_sqrt=sqrt(hindfoot_length)) %>% 
    filter(is.na(hindfoot_sqrt) | hindfoot_sqrt < 3) %>% 
    select(species_id, hindfoot_sqrt)

# count individuals by sex
surveys %>% 
    group_by(sex) %>% 
    tally()

# average weight by sex
surveys %>% 
    group_by(sex) %>% 
    summarize(mean_weight = mean(weight, na.rm=TRUE) )

surveys %>% 
    filter(!is.na(sex), sex != "") %>%  # <- need one or the other condition
    group_by(sex) %>% 
    summarize(mean_weight = mean(weight, na.rm=TRUE) )

# average weight by sex and by species_id    
surveys %>% 
    group_by(sex, species_id) %>% 
    summarize(mean_weight = mean(weight, na.rm=TRUE) )
    
# average weight by sex and by species_id
#   sort by mean weight
surveys %>% 
    group_by(sex, species_id) %>% 
    summarize(mean_weight = mean(weight, na.rm=TRUE) ) %>% 
    arrange(mean_weight)
    
# average weight by sex and by species_id
#   sort by mean weight, descending
surveys %>% 
    filter(!is.na(sex)) %>% 
    group_by(sex, species_id) %>% 
    summarize(mean_weight = mean(weight, na.rm=TRUE) ) %>% 
    arrange(desc(mean_weight)) %>% 
    filter(!is.na(mean_weight)) %>% 
    tail
    
# challenge
surveys %>% 
    group_by(plot_type) %>% 
    tally()


###############

# keep only rows that have complete data
surveys_complete <- surveys %>% 
    filter(!is.na(weight)) %>% 
    filter(!is.na(hindfoot_length)) %>% 
    filter(sex != "", !is.na(sex)) %>% 
    filter(species_id != "", !is.na(species_id))

# count species
species_counts <- surveys_complete %>% 
    group_by(species_id) %>% 
    tally()

# frequent species...counts >= 10
frequent_species <- species_counts %>% 
    filter(n >= 10) %>% 
    select(species_id)

# filter out less-frequent species 
reduced <- surveys_complete %>% 
    filter(species_id %in% frequent_species$species_id)

# save the reduced data to a file
write.csv(reduced, "CleanData/portal_data_reduced.csv")

## Now to the data visualization
library(ggplot2)

# a first plot
ggplot(reduced, aes(x=weight, y=hindfoot_length)) +
    geom_point()

# save thing-to-be-plotted to an object
p <- ggplot(reduced, aes(y=weight, x=hindfoot_length)) +
    geom_point()

# build that up in two steps
p1 <- ggplot(reduced, aes(x=weight, y=hindfoot_length))
p2 <- p1 + geom_point()

# challenge 9
reduced_DM <- reduced %>% 
    filter(species_id == "DM")

ggplot(reduced_DM, aes(x=weight, y=hindfoot_length)) +
    geom_point()

# or fully piped
reduced %>% 
    filter(species_id == "DM") %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point()

# use some other aesthetics
p <- reduced %>% 
    filter(species_id == "DM") %>% 
    ggplot(aes(x=weight, y=hindfoot_length))
p + geom_point(color = "slateblue")
p + geom_point(color = "slateblue", size=2)
p + geom_point(color = "slateblue", size=0.5)
p + geom_point(color = "slateblue", alpha=0.1)

# map further features aesthetics
ggplot(reduced, aes(x=weight, y=hindfoot_length))+
    geom_point(aes(color = species_id))

# challenge 10
summaries <- reduced %>% 
    group_by(species_id) %>% 
    summarize(mean_weight=mean(weight),
              mean_hfl = mean(hindfoot_length),
              sample_size = n()) # for sample size

ggplot(summaries, aes(x=mean_weight, y=mean_hfl)) +
    geom_point(aes(size=sample_size))

# geom_line to make a line plot
count_by_year <- reduced %>% 
    group_by(year) %>% 
    tally()
ggplot(count_by_year, aes(x=year, y=n)) +
    geom_line(color="slateblue") + geom_point()
ggplot(count_by_year, aes(x=year, y=n)) +
     geom_point(aes(color=year)) + geom_line()

# challenge 11
dmds_counts <- reduced %>% 
    filter(species_id=="DM" | species_id=="DS") %>% 
    group_by(year, species_id) %>% 
    tally()

ggplot(dmds_counts, aes(x=year, y=n, group=species_id)) +
    geom_line()

ggplot(reduced, aes(x=weight, y=hindfoot_length)) +
    geom_point() + facet_wrap(~ species_id)

ggplot(reduced, aes(x=weight, y=hindfoot_length)) +
    geom_point() + facet_grid(~ year)

reduced %>% 
    filter(year < 1983) %>% 
    filter(species_id == "DM" | species_id == "DS") %>% 
ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point() + facet_grid(species_id ~ .)

# univariate plots
ggplot(reduced, aes(x=weight)) +
    geom_histogram() + facet_wrap(~ species_id)

ggplot(reduced, aes(x=species_id, y=weight)) +
    geom_boxplot() 

ggplot(reduced, aes(x=species_id, y=weight)) +
    geom_boxplot() + theme_bw()

# save a plot to a file
p <- ggplot(reduced, aes(x=species_id, y=weight)) +
    geom_boxplot() + theme_bw()
ggsave("~/Desktop/my_ggplot.png", p, 
       height=8, width=10)
ggsave("~/Desktop/my_ggplot.pdf", p, 
       height=8, width=10)
