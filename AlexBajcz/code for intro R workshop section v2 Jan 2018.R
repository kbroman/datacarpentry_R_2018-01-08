#Math operations in R
15 + 5
15 - 5
15 * 5
15/5 #Show space is unnecessary.

#Functions --some of this is going to be a bit different now but that's ok.
log(5)
log(5, 6)
log() #Show data to log is needed.
log(x = 5) #Show that x is the name of the first argument.
log(x = 5, base = 3) #We can name which input goes with which argument.
log(5, 3) #Without doing so, order of inputs matters.
log(3, 5)
log(base = 3, x = 5) #But, with names, order no longer matters.
?log #Show help page for function

#Script files
15 - 5
#Hit enter to demonstrate hitting enter won't run code from script like it does in console.
15 - 5
15 + 5 #Demonstrate the power of comments!

#Objects
math <- 15 + 5 #Makes an object called math that holds "20"
math #Show that R knows what math means.
math / 7.43 #Can now use math in place of the number 20 in math problems.
new_math <- math / 7.43 #Make new object with the value in an old object.

blah = 4 #Show that = sign works too for assignment.

#Object names
meh1 <- 6 #Can contain numbers
1meh <- 6 #Can't start with one though.
t2 <- 8 #Can be short names.
sfieifsegjbwrjgbsrijgbsrjbgkjwbfkwjbfgkjsbfksjbs <- 0 #Or long names. But in between is better.

mean, t, c, data #All function names! Don't pick them.
mean <- 8 #Technically allowed, but don't do it.
column.name <- 8 #Also allowed, but don't do it because functions often use . to separate words.
Age = 18 #Demonstrate case-sensitivity of R
age #Not found because Age and age are different!

COLUMN_NAME #I use caps and underscores in my naming convention.
ColumnName #Others use Camelcase

#Challenge 1: 
x <- 50
y <- x * 2
x <- 75
y #Show that y is 100
y <- x * 2 #Show we have to run this again to change y.
y #Show that y is now 150 once we do that.

##Opening and working with the data.
surveys <- read.csv(file = "http://kbroman.org/datacarp/portal_data_joined.csv")

head(surveys)#Showcasing functions for exploring data frames.
tail(surveys)
dim(surveys)
nrow(surveys)
ncol(surveys)
names(surveys)

#Really powerful exploration tools!
str(surveys)
summary(surveys)

##Indexing--extracting values out of an object that we've made.
surveys[25]
surveys[1,5] #Value in row 1, column 5.
surveys[7,] #We can get the whole seventh row...
surveys[5:7,] #Or the 5th thru seventh rows.
surveys[5:7, -1] #Or that but without the first column.

surveys$sex #Columns can also be gotten using their names.

surveys_last <- surveys[nrow(surveys),] #Answer to the 2nd optional challenge. This will save just the last row of surveys into a new object.
