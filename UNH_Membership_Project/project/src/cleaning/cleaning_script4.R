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
data <- data[data$`Product: Record Type` != "Donation"]
data <- data[data$`Product: Record Type` != "Coupon"]
data <- data[!(data$`Product: Category` == "Book" & data$`Unit Price` == 0)]
data <- data[!(data$`Product: Category` == "ebook" & data$`Unit Price` == 0)]
data <- data[!(data$`Product: Category` == "White Paper" & data$`Unit Price` == 0)]

#Converting date formats and specifying our date range
data$`Created Date`<- as.Date(data$`Created Date`, "%m/%d/%Y")
data$`Transaction Date` <- as.Date(data$`Transaction Date`, "%m/%d/%Y")

data <- data[data$`Transaction Date` < as.Date('2022-01-01')]


#removing columns that aren't important
remove <- c("OTP", "Designation", "Default Country", "Product: Short Name", "Account Safe Id", 
            "Account Safe Id-1", "Account Record Type-1", "Member-1", "Member Type-1", "Status", 
            "Person Account: Lead Source", "Certified", "Member", "Product: Category")
data <- data[, remove:=NULL, with=FALSE]

#########################################
###############TESTING###################
#########################################

unique(data$`Product: Record Type`)

data_1 <- data[data$`Order Id` == "Order 0206298"]

###############CASE######################
data_2 <- data[data$`Order Id` == "Order 0029542"]
#########################################

data_3 <- data[data$`Product: Record Type` == "Coupon"]
data_4 <- data[data$`Unique ID` == "34049"]
data_4 <- data[data$`Unique ID` == "320160"]

data_4 <- data[data$`Unique ID` == "305058"]
data_4 <- data[data$`Unique ID` == "340858"]


data <- data[data$`Product: Record Type` == "Coupon" & data$`Unit Price` < 0]

#########################################
#########################################
#########################################

#writing out our cleaned data
fwrite(data, './UNH_Membership_Project/project/volume/data/interim/cleaned_data.csv')
