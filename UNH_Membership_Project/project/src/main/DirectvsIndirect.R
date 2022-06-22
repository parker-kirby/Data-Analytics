#Direct vs Indirect Memberships

data <- fread('./UNH_Membership_Project/project/volume/data/intrim/raw_data.csv')

#Defining columns for the different types of membership
data$direct <- 0
data$OTP_indirect <- 0
data$bundle_indirect <- 0
data$comp_indirect <-0

#Direct membership
direct_list = c("Professional", "Not-For-Profit", "Government", "Higher Education", "Retired", "Transitional", "Student")
data$direct[data$`Product: Product Name` %in% direct_list & data$`Unit Price` > 0] <- 1