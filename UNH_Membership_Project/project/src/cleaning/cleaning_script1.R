library(data.table)
library(carat)

#read in our data
data <- fread('./UNH_Membership_Project/project/volume/data/raw/raw_data.csv')

remove <- c("OTP", "Designation", "Default Country", "Product: Category", "Product: Product Name", "Account Safe Id", 
            "Account Safe Id-1", "Account Record Type-1", "Member-1", "Member Type-1", "Status", 
            "Person Account: Lead Source", "Member Type")
data <- data[, remove:=NULL, with=FALSE]

#removing memberships that aren't individual
data <- data[data$`Membership Category` == "Individual"]

