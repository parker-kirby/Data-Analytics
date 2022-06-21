install.packages("tidyverse")
library(tidyverse)

#put data into a data frame
data <- 
  df <- data.frame(data)

#rename columns??

#remove unnecessary columns (person account: lead source, OTP, designation, 
#   certified, all "-1" columns)
df2 <- subset(df, select = -c())

#remove unnecessary rows (no history of being a member, membership category 
#   = "company")
df3 <- subset(df2, Membership_Category != "company")


#hi
#now
