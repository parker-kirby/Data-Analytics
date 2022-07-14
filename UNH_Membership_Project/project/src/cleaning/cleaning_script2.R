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
#data <- data[data$`Product: Record Type` != "Merchandise"] 

#Converting date formats and specifying our date range
data$`Created Date`<- as.Date(data$`Created Date`, "%m/%d/%Y")
data$`Transaction Date` <- as.Date(data$`Transaction Date`, "%m/%d/%Y")

data <- data[data$`Transaction Date` < as.Date('2022-01-01')]


#removing columns that aren't important
remove <- c("OTP", "Designation", "Default Country", "Product: Category", "Product: Short Name", "Account Safe Id", 
            "Account Safe Id-1", "Account Record Type-1", "Member-1", "Member Type-1", "Status", 
            "Person Account: Lead Source", "Certified", "Member")
data <- data[, remove:=NULL, with=FALSE]


###############TESTING###################

unique(data$`Product: Record Type`)
data1 <- data[data$`Order Id` == "Order 0222749"]
data2 <- data[data$`Order Id` == "Order 0105183"]
data3 <- data[data$`Product: Record Type` == "Donation"]
data4 <- data[data$`Unique ID` == "34248"]

#########################################
data <- data[data$`Product: Record Type` == "Coupon" & data$`Unit Price` < 0]

dt1 <- data[duplicated(data$`Order Id`)]
dt2 <- dt1[dt1$`Product: Record Type` == "Membership" & dt1$`Unit Price` == 0]
dt3 <- dt1[dt1$`Product: Record Type` == "Membership" & dt1$`Unit Price` > 0]
dt4 <- dt1[dt1$`Product: Record Type` == "Membership" & dt1$`Unit Price` < dt1$`Total Payment` & dt1$`Unit Price` > 0]

#########################################

#writing out our cleaned data
fwrite(data, './UNH_Membership_Project/project/volume/data/interim/cleaned_data.csv')
