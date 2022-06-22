library(data.table)
library(dplyr)
library(carat)

#read in our data
data <- fread('./UNH_Membership_Project/project/volume/data/raw/raw_data.csv')

#removing records that won't be used for analysis
data <- distinct(data)
data <- data[data$`Account Record Type` == "Individual"]
data <- data[data$`Membership Category` == "Individual"]
data <- data[data$Status == "Active"]
data <- data[data$`Member Type` != "Individual Green Membership"]
data <- data[data$`Member Type` != "Press"]
data <- data[data$`Product: Record Type` != "Merchandise"] 

#Converting date formats and specifying our date range
data$`Created Date`<- as.Date(data$`Created Date`, "%m/%d/%Y")
data$`Transaction Date` <- as.Date(data$`Transaction Date`, "%m/%d/%Y")

data <- data[data$`Transaction Date` < as.Date('2022-01-01')]


#removing columns that aren't important
remove <- c("OTP", "Designation", "Default Country", "Product: Category", "Product: Short Name", "Account Safe Id", 
            "Account Safe Id-1", "Account Record Type-1", "Member-1", "Member Type-1", "Status", 
            "Person Account: Lead Source", "Certified", "Member")
data <- data[, remove:=NULL, with=FALSE]


##############TESTING###################

unique(data$`Product: Record Type`)
data1 <- data[data$`Order Id` == "Order 0105201"]
data2 <- data[data$`Order Id` == "Order 0199073"]

########################################


fwrite()
