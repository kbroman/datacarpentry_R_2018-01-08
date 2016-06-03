# R script from Data Carpentry Workshop
# 2016-06-02
# http://uw-madison-aci.github.io/2016-06-01-uwmadison
#
# Karl Broman, http://kbroman.org

## R introduction

# first calculation
2016 - 1969

# arthimetic in R
4+6
4*6
4/6
4^6
sqrt(46)
log(46)
log10(46)
log(46, 10)

# assignment
age <- 2016 - 1969
sqrt_age <- sqrt(age)
age <- age - 1 
sqrt_age
sqrt(age)

# vectors
weights <- c(30, 100, 4000, 8000)
length(weights)
animals <- c("rat", "cat")
length(animals)
class(animals)
class(weights)
str(weights)
str(animals)

# adding to a vector
animals <- c(animals, "dog")
animals <- c("mouse", animals)

# must be one type
x <- c(1, 2, 3, "a")
y <- c(4, 5, TRUE, 6)
z <- c("text", TRUE)
tricky <- c(1, 2, 3, "4", 5)

# indexing/subsetting
weights
weights[1]
weights[2]
weights[c(1,3)]
length(animals)
animals[c(1, 2, 3, 1, 2, 4)]
animals[c(2,3)]

# indexing with negative values
animals[-1]
animals[c(-2, -3)]
animals[-c(2,3)]

# calculations to the whole vector
-weights
weights*2.2/1000
sqrt(weights)
log10(weights)

# indexing by logical values
save_these <- c(TRUE, FALSE, FALSE, TRUE)
weights[save_these]

weights[weights < 50]
animals[weights < 200]
animals[weights < 50 | weights > 5000]
animals[weights > 50 & weights < 5000]
weights[animals %in% c("rat", "cat")]

# missing values
heights <- c(2, 4, 4, NA, 6)
mean(heights, na.rm=TRUE)
max(heights)
max(heights, na.rm=TRUE)
is.na(heights)
heights[is.na(heights)]
heights[!is.na(heights)]
na.omit(heights)

# remove all objects
rm(list=ls())

## data frames
# load the data
url <- "http://kbroman.org/datacarp/portal_data_joined.csv"
filename <- "data/portal_data_joined.csv"
download.file(url, filename)
surveys <- read.csv(filename)

# this also works
surveys <- read.csv(url)

# summary info about data.frame
class(surveys)
str(surveys)
head(surveys)
head(surveys, 2)
tail(surveys)
tail(surveys, 2)
dim(surveys)
nrow(surveys)
ncol(surveys)
summary(surveys)
names(surveys)
colnames(surveys)
rownames(surveys)

# factors
sex <- factor( c("male", "female", "female", "male"))
sex
class(sex)
levels(sex)
nlevels(sex)
sex <- factor( c("male", "female", "female", "male"),
               levels=c("male", "female"))
sex_char <- as.character(sex)
sex_char

numbers <- factor(c("1", "5", "8", "4"))
numbers_alt <- factor(c(1, 5, 8, 4))
levels(numbers)
levels(numbers_alt)
as.numeric(as.character(numbers))

expt <- c("treat1", "treat2", "treat1", "treat3", "treat1",
          "control", "treat1", "treat2", "treat3")
expt <- factor(expt)
table(expt)
levels(expt)

expt <- c("treat1", "treat2", "treat1", "treat3", "treat1",
          "control", "treat1", "treat2", "treat3")
expt <- factor(expt, levels=c("treat1", "treat2", "treat3", "control"))
table(expt)
levels(expt)

HELLNO <- FALSE
surveys_nofactors <- read.csv("data/portal_data_joined.csv",
                              stringsAsFactors=HELLNO)

# indexing of data frames
surveys[1,1]
surveys[4,7]
surveys[2,7]
surveys[2,]
surveys[,7]
sex <- surveys[,"sex"]
sex <- surveys$sex
sex <- surveys[["sex"]]

# sequences, : and seq
5:10
1:10
seq(5, 10, by=2)
seq(5, 10, by=0.5)
seq(5, 10, length.out=26)

# slices of data frame
surveys[10:20, 2:4]

male_weights <- surveys[surveys$sex =="M", "weight"]
male_weights <- surveys$weight[surveys$sex=="M"]
mean(male_weights, na.rm=TRUE)
mean(surveys[surveys$sex =="M", "weight"], na.rm=TRUE)

install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)

selected_col <- select(surveys, species_id, sex)
filter(surveys, sex=="M")

#pipe
surveys  %>% filter(sex=="M", weight < 10) %>% 
    select(species_id, sex)

surveys  %>% select(species_id, sex, weight) %>% 
    filter(sex=="M", weight < 5)

surveys  %>% select(species_id, sex, weight) %>% 
    filter(sex=="M" | weight < 5)

surveys  %>% select(species_id, sex, weight) %>% 
    filter(sex %in% c("F", "M"), weight < 5)

# Using pipes, subset the data to 
# include individuals collected before 1995, 
# and retain the columns year, sex, and weight.
selected_col_to1995 <- surveys %>% filter(year < 1995) %>% 
    select(year, sex, weight)

# mutate
surveys %>% filter(!is.na(weight)) %>% 
    mutate(sqrt_weight=sqrt(weight), weight=weight*2.2) %>% 
    head

# change weight to lbs
surveys <- mutate(surveys, weight_lb=weight*2.2/1000)

# pipes, select, filter
head(surveys)
surveys %>% head
head(select(surveys, species_id, weight) )
surveys %>% select(species_id, weight) %>% head

head(select(filter(surveys, weight<6), species_id, weight))

filtered <- filter(surveys, weight<6)
selected <- select(filtered, species_id, weight)
head(selected)

surveys %>% filter(weight<6) %>% 
    select(species_id, weight) %>% head

challenge_result <- surveys %>% 
    mutate(hindfoot_sqrt = sqrt(hindfoot_length)) %>% 
   filter(hindfoot_sqrt < 3) %>% 
   select(species_id, hindfoot_sqrt) 

# arrange
challenge_result %>% arrange(hindfoot_sqrt)
challenge_result %>% arrange(desc(hindfoot_sqrt), species_id)

# group by
surveys %>% group_by(sex) %>% tally
surveys %>% group_by(sex, year) %>% tally
surveys %>% group_by(sex) %>% 
    summarize(mean_weight=mean(weight, na.rm=TRUE))
surveys %>% group_by(sex) %>% 
    filter(!is.na(weight)) %>% 
    summarize(mean_weight=mean(weight))
surveys %>% filter(!is.na(weight)) %>% 
    group_by(sex) %>% 
    summarize(mean_weight=mean(weight))

surveys %>% filter(!is.na(weight), sex!="") %>% 
    group_by(sex, species_id) %>% 
    summarize(mean_weight=mean(weight))

surveys %>% group_by(plot_type) %>% tally

surveys %>% filter(!is.na(weight), sex!="") %>% 
    group_by(sex, species_id) %>% 
    summarize(mean_weight=mean(weight),
              min_weight=min(weight),
              max_weight=max(weight)) %>% 
    arrange(mean_weight)

# some data cleaning
surveys_complete <- surveys %>% 
    filter(!is.na(hindfoot_length)) %>% 
    filter(!is.na(weight)) %>% 
    filter(sex != "")

# count species
species_count <- surveys_complete %>% 
    group_by(species_id) %>% tally

# species with >= 10 count
frequent_species <- species_count %>% 
    filter(n>=10)

# save just rows with species_id count >= 10
surveys_complete <- surveys_complete %>% 
    filter(species_id %in% frequent_species$species_id)

# ggplot2
library(ggplot2)
surveys_complete %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point()

p1 <- surveys_complete %>% 
    ggplot(aes(x=weight, y=hindfoot_length))
p2 <- p1 + geom_point()
p2 + scale_x_log10()
p2 + scale_x_sqrt()

surveys_complete %>% filter(species_id=="DM") %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point()

# other aesthetics : size, color, alpha, shape
surveys_complete %>% filter(species_id=="DM") %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point(alpha=0.1, color="slateblue", size=20)

surveys_complete %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point(aes(color=species_id))

surveys_complete %>% 
    filter(species_id %in% c("DM", "DS", "DO")) %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point(aes(color=species_id))

surveys_complete %>% 
    filter(species_id %in% c("DM", "DS", "DO")) %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point(aes(shape=species_id))

surveys_complete %>% 
    filter(species_id %in% c("DM", "DS", "DO")) %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point(aes(color=species_id, shape=species_id))

surveys_complete %>% group_by(year) %>% tally %>% 
    ggplot(aes(x=year, y=n)) + geom_line()

surveys_complete %>% group_by(year) %>% tally %>% 
    ggplot(aes(x=year, y=n)) + geom_line(color="lightblue") +
    geom_point(color="violetred", size=2)

surveys_complete %>% group_by(year) %>% 
    summarize(mean_hfl=mean(hindfoot_length)) %>% 
    ggplot(aes(x=year, y=mean_hfl)) + 
    geom_line(color="lightblue") +
    geom_point(color="violetred", size=2)

surveys_complete %>% filter(species_id %in% c("DM", "DS")) %>% 
    group_by(year, species_id) %>% 
    tally %>% 
    ggplot(aes(x=year, y=n)) + 
    geom_line(aes(group=species_id)) +
    geom_point(aes(color=species_id))

surveys_complete %>% filter(species_id %in% c("DM", "DS")) %>% 
    group_by(year, species_id) %>% 
    tally %>% 
    ggplot(aes(x=year, y=n, group=species_id)) + 
    geom_line() +
    geom_point(aes(color=species_id, size=n))

# histogram
surveys_complete %>% ggplot(aes(x=weight)) +
    geom_histogram(bins=200)

# boxplots
surveys_complete %>% 
    ggplot(aes(y = species_id, x=weight)) +
    geom_boxplot()

surveys_complete %>% 
    ggplot(aes(x = species_id, y=weight)) +
    geom_jitter(col="Orchid", alpha=0.1) +
    geom_boxplot()

# faceting
surveys_complete %>% 
    group_by(year, species_id) %>% 
    tally %>% ggplot(aes(x=year, y=n)) +
    geom_line() + facet_wrap(~ species_id)

surveys_complete %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point() + facet_wrap(~ species_id)    

surveys_complete %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point(aes(color=species_id)) + facet_wrap(~ year)

surveys_complete %>% 
    filter(species_id %in% c("DM", "DS", "DO")) %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point(aes(color=species_id)) + facet_wrap(~ year)

surveys_complete %>% 
    filter(species_id %in% c("DM", "DS", "DO")) %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point(aes(color=species_id)) + facet_grid(~ species_id)

surveys_complete %>% 
    filter(species_id %in% c("DM", "DS", "DO")) %>% 
    filter(round(year, -1) == year) %>% 
    ggplot(aes(x=weight, y=hindfoot_length)) +
    geom_point(aes(color=species_id)) + facet_grid(species_id ~ year)
