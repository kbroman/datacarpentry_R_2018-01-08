##First thing's first--let's make sure we have our surveys object.

surveys <- read.csv("surveys_cleaned.csv") #Only necessary if you restarted R or got rid of surveys somehow. Otherwise, you should have it already.

##Next, turn on the dplyr package using the Packages tab or by typing:
library(dplyr) #If this doesn't work, you may need to download dplyr or tidyverse using the Packages tab--ask for help!

#Let's start with some simpler manipulations.
#1st Problem: Getting back only some columns of a data sheet -- select.

select(surveys, month, hindfoot_length) #The first argument is the data sheet--only the columns put in subsequent argument slots are saved in the process and the rest are dropped.

#Challenge 1.
small_surveys = select(surveys, species_id, sex, weight) #The first argument is the data sheet.
small_surveys #Only those three columns saved.

#2nd Problem: We want to sort the data sheet -- arrange.

arrange(small_surveys, weight) #First argument is the data sheet again--the second is the column to sort by.
arrange(small_surveys, weight, sex) #You can sort by a second column by putting it next, and so on.
arrange(small_surveys, desc(weight)) #Use the desc() function to sort in descending order instead.

#Challenge 2.
sorted_surveys = arrange(small_surveys, species_id, desc(weight))
sorted_surveys #Successfully sorted!

#3rd Problem: We want to create a new column using a preexisting column -- mutate.

mutate(sorted_surveys, weight / 1000) #Creates a new column for the newly calculated weights.
mutate(sorted_surveys, kg_weight = weight / 1000) #Names the new column.

#Challenge 3. 
mutated_surveys = mutate(sorted_surveys, sqrt_weights = sqrt(weight)) #?sqrt() for help. 
mutated_surveys #Took the square root and named the column.

#4th problem: We want to get back only some rows from our data set -- filter.

filter(mutated_surveys, weight == 18) #Only gets back rows with a weight = 18. == is necessary because = already means something.
filter(mutated_surveys, weight < 25) #Less than and greater than. 
filter(mutated_surveys, weight >= 100) #Greater than or equal to looks like this.
filter(mutated_surveys, sex != "M") #!= means is not equal to. Remember, sex is text, so you need the quotes.
filter(mutated_surveys, sex != "M", weight == 45) #You can have two match rules, or more!

#Challenge 4. 
filtered_surveys = filter(mutated_surveys, sex == "F", weight <= 50) #Two rules successfully applied. 
filtered_surveys

#5th problem: We want to summarize our data -- group_by and summarize.

grouped_surveys = group_by(filtered_surveys, species_id) #This groups the data by species_id, albeit invisibly. 
grouped_surveys #We can't "see" that it's done anything, but it has.

summarized_surveys = summarize(grouped_surveys, mean(weight)) #The mean() function takes an average.
summarized_surveys #We have the mean weights of each unique species_id. 

summarized_surveys = summarize(grouped_surveys, mean = mean(weight)) #Names the new column.
summarized_surveys

grouped_surveys2 = group_by(mutated_surveys, species_id, sex) #You can group the data by multiple columns--each unique combo will get a summary.
summarize(grouped_surveys2, count = n()) #Counts the number of observations for each species and sex combo.

#The pipe operator %>%
filtered_surveys %>% group_by(species_id) %>% summarize(mean = mean(weight)) #Using pipes, we can do both steps in one line of code!

#Challenge 5. Combine all the steps so far into a single step!
surveys %>% select(species_id, sex, weight) %>% arrange(species_id, desc(weight)) %>% mutate(sqrt_weight = sqrt(weight)) %>% filter(sex == "F", weight <= 50) %>% group_by(species_id) %>%  summarize(mean = mean(weight))
#Huzzah!

##Making the data sets needed for the ggplot2 unit.
#First, let's make a data set with just the data for the species_id "DM"

just_dm <- surveys %>% filter(species_id == "DM")

#Second, get the means weights, hindfoot lengths, and counts for each species.

stat_summary <- surveys %>% group_by(species_id) %>% summarize(mean_weight = mean(weight), 
                                                               mean_length = mean(hindfoot_length), count = n())

#Lastly, let's get the yearly number of observations for each species and sex combination, as well as the average weights and hindfoot lengths.

year_summary <- surveys %>% group_by(year, sex, species_id) %>% summarize(count = n(), mean_weight = mean(weight), mean_length = mean(hindfoot_length))

