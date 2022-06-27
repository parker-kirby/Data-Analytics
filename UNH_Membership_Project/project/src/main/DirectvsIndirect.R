#Direct vs Indirect Memberships

data <- fread('./UNH_Membership_Project/project/volume/data/intrim/cleaned_data.csv')

#Defining columns for the different types of membership
data$direct <- 0
data$OTP_indirect <- 0
data$bundle_indirect <- 0
data$comp_indirect <-0


##########################################################################################################
#Direct membership
data_list <- data[(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0]

membership_list = c("Professional", "Not-For-Profit", "Government", "Higher Education", "Retired", "Transitional", "Student")
#data$direct[data$`Product: Product Name` %in% direct_list & data$`Unit Price` > 0 & data$`Total Payment` >= data$`Unit Price`] <- 1
data1 <- data[data$`Product: Product Name` %in% membership_list & data$`Unit Price` > 0 & data$`Total Payment` >= data$`Unit Price`]


#Get rid of records in data list
non_use = c(data_list$`Order Id`)
'%notin%' <- Negate('%in%')

data2 <- data1[data1$`Order Id` %notin% non_use]

data3 <- data2[duplicated(data2$`Order Id`)]


##########################################################################################################
#Indirect OTP

#data$OTP_indirect[duplicated(data$`Order Id`) & data$`Unit Price` == 0 & data$`Total Payment` == 0] <- 1

free_memberships <- data[data$`Product: Product Name` %in% membership_list & data$`Unit Price` == 0 & data$`Total Payment` > 0]

test_indirect <- data[(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0 & data$`Total Payment` == 0]

Final_OTP <- test_indirect[test_indirect$`Order Id` %in% free_memberships$`Order Id`]

OTP <- Final_OTP[Final_OTP$`Product: Product Name` %in% membership_list]

