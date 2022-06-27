#Direct vs Indirect Memberships

data <- fread('./UNH_Membership_Project/project/volume/data/intrim/cleaned_data.csv')

#Defining columns for the different types of membership
data$direct <- 0
data$OTP_indirect <- 0
data$bundle_indirect <- 0
data$comp_indirect <-0

membership_list = c("Professional", "Not-For-Profit", "Government", "Higher Education", "Retired", "Transitional", "Student")

##########################################################################################################
#Direct membership
data_list <- data[(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0]

#data$direct[data$`Product: Product Name` %in% direct_list & data$`Unit Price` > 0 & data$`Total Payment` >= data$`Unit Price`] <- 1
data1 <- data[data$`Product: Product Name` %in% membership_list & data$`Unit Price` > 0 & data$`Total Payment` >= data$`Unit Price`]


#Get rid of records in data list
non_use = c(data_list$`Order Id`)
'%notin%' <- Negate('%in%')

data2 <- data1[data1$`Order Id` %notin% non_use]

data3 <- data2[(duplicated(data2$`Order Id`) | duplicated(data2$`Order Id`, fromLast = TRUE))]


##########################################################################################################
#Indirect OTP

#data$OTP_indirect[duplicated(data$`Order Id`) & data$`Unit Price` == 0 & data$`Total Payment` == 0] <- 1

OTP_indirect <- data[(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0 & data$`Total Payment` == 0]

Final_OTP <- test_indirect[test_indirect$`Product: Product Name` %in% membership_list]


#########################################################################################################
#Indirect Comp
comped1 <- data[data$`Product: Product Name` %in% membership_list & data$`Unit Price` > 0 & data$`Total Payment` == 0]
comped2 <- data[data$`Product: Product Name` %in% membership_list & data$`Unit Price` == 0 & data$`Total Payment` == 0 & !(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE))]

Final_Comp<- rbind(comped1, comped2)

#########################################################################################################
#Indirect Bundle

bundle1 <- data[data$`Product: Product Name` %in% membership_list & (duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0 & data$`Total Payment` > 0]

bundle2 <- data[data$`Product: Product Name` %in% membership_list & (duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price`> 0 & data$`Total Payment`> 0 & data$`Unit Price` <= data$`Total Payment`]
bundle2 <- bundle2[bundle2$`Order Id` %in% non_use]
  
Final_Bundle <-

