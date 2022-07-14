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

#removing columns that aren't important
remove <- c("OTP", "Designation", "Default Country", "Product: Category", "Product: Product Name", "Account Safe Id", 
            "Account Safe Id-1", "Account Record Type-1", "Member-1", "Member Type-1", "Status", 
            "Person Account: Lead Source")
data <- data[, remove:=NULL, with=FALSE]


