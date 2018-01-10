15 + 5
15 - 5 #Anything after the # is stuff R will ignore when running code!
#R will ignore this when running a block of code with it in it

math <- 15 + 5
math
math / 6
new_math <- 6 + math

x <- 50
y <- x * 2
x <- 75
y

math2 = 8

tp <- 9

dbfisegfisugfiwegfiwehfbiweufhwieufgbweirjfb <-10

blah1 <- 19
1blah <-10

mean, c, t, data

mean <- 8
mean_wgt
MeanWgt

Age <- 18
age

?mean

COLUMN_NAMES

surveys <- read.csv("http://kbroman.org/datacarp/portal_clean.csv")

head(surveys)
tail(surveys)
nrow(surveys)
ncol(surveys)
names(surveys)

str(surveys)
summary(surveys)

surveys[1, 5]
surveys[5, 1]

surveys[1, ]
surveys[, 5]

surveys[1, -5]

surveys[1, 5] <- 4
surveys[1, 5]

saved_info <- surveys[1,]
saved_info

nrows <- nrow(surveys)

surveys_last <- surveys[nrow(surveys), ]

surveys[,5]

1:10
10:-5

c(3, -1000, pi)

surveys[1:4, c(3, 5, 8)]

library(dplyr)

test1 <- select(surveys, plot_id, weight, sex)
test1

small_surveys <- select(surveys, species_id, sex, weight)
small_surveys

arrange(small_surveys, weight)
arrange(small_surveys, weight, species_id)
arrange(small_surveys, weight, desc(species_id))

sorted_surveys <- arrange(small_surveys, species_id, desc(weight))        
sorted_surveys

blah <- mutate(sorted_surveys, weight_kg = weight/1000)
blah

mutated_surveys <- mutate(sorted_surveys, sqrt_weight = sqrt(weight))
mutated_surveys

filter(mutated_surveys, weight == 18)
filter(mutated_surveys, weight > 18)
filter(mutated_surveys, weight <= 18)
filter(mutated_surveys, weight != 18)
filter(mutated_surveys, weight != 18, sex == "F")

filtered_surveys <- filter(mutated_surveys, sex == "F", weight <= 50)
filtered_surveys

grouped_surveys <- group_by(filtered_surveys, species_id)
grouped_surveys

summarized_surveys <- summarize(grouped_surveys, mean(weight))
summarized_surveys

grouped_surveys2 <- group_by(filtered_surveys, species_id, sex)

summarized_surveys <- summarize(grouped_surveys2, count = n())
summarized_surveys

filtered_surveys %>% group_by(species_id) %>% summarize( count = n())

surveys %>% select(species_id, sex, weight) %>% 
  arrange(species_id, desc(weight)) %>% 
  mutate(sqrt_weight = sqrt(weight)) %>% 
  filter(sex == "F", weight <= 50) %>% 
  group_by(species_id) %>% 
  summarize(count = n())
