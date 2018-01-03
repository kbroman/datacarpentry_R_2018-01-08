# clean the portal data

surveys <- read.csv("http://kbroman.org/datacarp/portal_data_joined.csv")

# remove all NAs
surveys <- surveys[rowSums(is.na(surveys))==0,]

# remove rows with "" in sex
surveys <- surveys[surveys$sex != "",]

# remove species with <10 counts
tab <- table(surveys$species_id)
low_counts <- names(tab)[tab < 10]
surveys <- surveys[!(surveys$species_id %in% low_counts),]

# write to CSV file
write.table(surveys, "portal_clean.csv", sep=",", quote=FALSE,
            row.names=FALSE, col.names=TRUE)
