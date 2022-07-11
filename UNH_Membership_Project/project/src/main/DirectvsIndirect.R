#Direct vs Indirect Memberships

data <- fread('./UNH_Membership_Project/project/volume/data/intrim/cleaned_data.csv')

membership_list = c("Professional", "Not-For-Profit", "Government", "Higher Education", "Retired", "Transitional", "Student")

##########################################################################################################
#Direct membership
data_list <- data[(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0]

#data$direct[data$`Product: Product Name` %in% direct_list & data$`Unit Price` > 0 & data$`Total Payment` >= data$`Unit Price`] <- 1
direct <- data[data$`Product: Product Name` %in% membership_list & data$`Unit Price` > 0 & data$`Total Payment` >= data$`Unit Price`]


#Get rid of records in data list
non_use = c(data_list$`Order Id`)
'%notin%' <- Negate('%in%')

Final_Direct <- direct[direct$`Order Id` %notin% non_use]
Final_Direct <- Final_Direct[!(duplicated(Final_Direct$`Order Id`))]

##########################################################################################################
#Indirect OTP

#data$OTP_indirect[duplicated(data$`Order Id`) & data$`Unit Price` == 0 & data$`Total Payment` == 0] <- 1

OTP_indirect1 <- data[(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0 & data$`Total Payment` == 0]
#OTP_indirect2 <- data[data$`Product: Product Name` %in% membership_list & (duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price`> 0 
 #                     & data$`Total Payment` == data$`Unit Price` & data$`Transaction Date` < as.Date('2019-01-01') ]


#############################################################################################################
#############################################################################################################
#############################################################################################################
OTP_indirect2 <- data[data$`Product: Product Name` %in% membership_list & (duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price`> 0]

OTP_indirect3 <- data[(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0 & data$`Product: Product Name` %notin% membership_list & data$`Total Payment` > 0]

orderup <- rbind(OTP_indirect2, OTP_indirect3)

orderup <- orderup[(duplicated(orderup$`Order Id`) | duplicated(orderup$`Order Id`, fromLast = TRUE))]

listed <- orderup$`Order Id`[orderup$`Product: Product Name` %in% membership_list]

orderup <- orderup[orderup$`Order Id` %in% listed]

listed2 <- orderup$`Order Id`[orderup$`Unit Price` == 0]

orderup <- orderup[orderup$`Order Id` %in% listed2]

listed3 <- orderup$`Order Id`[orderup$`Product: Product Name` == "CIPP/E Test Center Exam (First-Time Candidate)"]

Werid_OTPs <- orderup[orderup$`Order Id` %in% listed3]

#############################################################################################################
#############################################################################################################
#############################################################################################################


#########################################################################################################
#Indirect Comp
comped1 <- data[data$`Product: Product Name` %in% membership_list & data$`Unit Price` > 0 & data$`Total Payment` == 0]
comped2 <- data[data$`Product: Product Name` %in% membership_list & data$`Unit Price` == 0 & data$`Total Payment` == 0 & !(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE))]

Final_Comp<- rbind(comped1, comped2)

Final_Comp[Final_Comp$`Order Id` == "Order 0055506"]

#########################################################################################################
#Indirect Bundle

bundle1 <- data[data$`Product: Product Name` %in% membership_list & (duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0 & data$`Total Payment` > 0]

bundle2 <- data[data$`Product: Product Name` %in% membership_list & (duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price`> 0 & data$`Total Payment`> 0 & data$`Unit Price` <= data$`Total Payment`]
bundle2 <- bundle2[bundle2$`Order Id` %in% non_use]
  
Final_Bundle <- rbind(bundle1, bundle2)
Final_Bundle <- Final_Bundle[(!(duplicated(Final_Bundle$`Order Id`)))]

Final_Bundle[Final_Bundle$`Order Id` == "Order 0191672"]

#Write out our final tables
fwrite(Final_Direct, './UNH_Membership_Project/project/volume/data/processed/Final_Direct.csv')
fwrite(Final_OTP, './UNH_Membership_Project/project/volume/data/processed/Final_OTP.csv')
fwrite(Final_Comp, './UNH_Membership_Project/project/volume/data/processed/Final_Comp.csv')
fwrite(Final_Bundle, './UNH_Membership_Project/project/volume/data/processed/Final_Bundle.csv')

