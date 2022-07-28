library(data.table)
library(dplyr)
library(carat)

#read in our data
data <- fread('./Sales_Project/project/volume/data/raw/raw_data.csv')

'%notin%' <- Negate('%in%')

remove <- c( "Member Status Update Date", "Member First Responded Date", 
             "Designation", "Account Name", "Member")
data <- data[, remove:=NULL, with=FALSE]

data[is.na(data)] <- "none"
data[is.null(data)] <- "none"
data[data == ""] <- "none"

#Converting date formats and specifying our date range
data$`Member First Associated Date` <- as.Date(data$`Member First Associated Date`, "%m/%d/%Y")
data$`Transaction Date` <- as.Date(data$`Transaction Date`, "%m/%d/%Y")

no_transaction <- data$Email[is.na(data$`Transaction Date`)]

###############################################
#Testing

testing <- data[data$Email == "jenna.coudin@ukg.com"]

finding <- data[data$New == 1 & data$`Successful Lead` == 0]
finding2 <- data[data$New == 1 & data$`Successful Lead` == 1]

###############################################

#New Columns
data$New[data$`Transaction Date` < data$`Member First Associated Date`] <- 0
not_new <- data$Email[data$New == 0]
data$New[data$Email %in% no_transaction & data$Email %notin% not_new] <- 1
data$New[data$`Transaction Date` >= data$`Member First Associated Date` & data$Email %notin% not_new] <- 1
data$New[data$Email %in% not_new] <- 0

data$`Successful Lead`[data$`Member First Associated Date` <= data$`Transaction Date` & data$New == 1 & data$Email %notin% no_transaction] <- 1
data$`Successful Lead`[data$New == 1 & data$Email %in% no_transaction] <- 0
data$`Successful Lead`[data$New == 0] <- 0


#SKIP
#NOT YET WORKING
data$`Days Between` <- seq(from = data$`Member First Associated Date`, to = data$`Transaction Date`, by = 'day') - 1


fwrite(data, './Sales_Project/project/volume/data/interim/cleaned_data.csv')

