#Direct vs Indirect Memberships

data <- fread('./UNH_Membership_Project/project/volume/data/interim/cleaned_data.csv')

membership_list = c("Professional", "Not-For-Profit", "Government", "Higher Education", "Retired", "Transitional", "Student")

kindasus <- data[data$`Product: Product Name` %in% membership_list]
kindasus <- kindasus[!duplicated(kindasus$`Order Id`)]
'%notin%' <- Negate('%in%')

#############################################################################################################
#############################################################################################################
#############################################################################################################

strange1 <- data[data$`Product: Product Name` %in% membership_list & (duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price`> 0]

strange2 <- data[(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0 & data$`Product: Product Name` %notin% membership_list & data$`Total Payment` > 0]

orderup <- rbind(strange1, strange2)

orderup <- orderup[(duplicated(orderup$`Order Id`) | duplicated(orderup$`Order Id`, fromLast = TRUE))]

listed <- orderup$`Order Id`[orderup$`Product: Product Name` %in% membership_list]

orderup <- orderup[orderup$`Order Id` %in% listed]

listed2 <- orderup$`Order Id`[orderup$`Unit Price` == 0]

orderup <- orderup[orderup$`Order Id` %in% listed2]

listed3 <- orderup$`Order Id`[orderup$`Product: Product Name` == "CIPP/E Test Center Exam (First-Time Candidate)" | orderup$`Product: Product Name` == "CIPM Test Center Exam (First-Time Candidate)"
                              | orderup$`Product: Product Name` == "CIPT Test Center Exam (First-Time Candidate)" | orderup$`Product: Product Name` == "CIPP/US Test Center Exam (First-Time Candidate)"
                              | orderup$`Product: Product Name` == "CIPP/E Test Center Exam (First-Time Candidate)" | orderup$`Product: Product Name` == "CIPP/E Test Center Exam (Retake)"]

Weird_OTPs <- orderup[orderup$`Order Id` %in% listed3]

Weird_OTPs <- Weird_OTPs[Weird_OTPs$`Unit Price` == Weird_OTPs$`Total Payment`]

listed4 <- Weird_OTPs$`Order Id`

Weird_Directs <- orderup[orderup$`Order Id` %notin% listed4]

Weird_Directs <- Weird_Directs[Weird_Directs$`Product: Product Name` %in% membership_list]
#############################################################################################################
#############################################################################################################
#############################################################################################################




##########################################################################################################
#Direct membership
data_list <- data[(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0]

#data$direct[data$`Product: Product Name` %in% direct_list & data$`Unit Price` > 0 & data$`Total Payment` >= data$`Unit Price`] <- 1
direct <- data[data$`Product: Product Name` %in% membership_list & data$`Unit Price` > 0 & data$`Total Payment` >= data$`Unit Price`]


#Get rid of records in data list
non_use = c(data_list$`Order Id`)

Final_Direct <- direct[direct$`Order Id` %notin% non_use]
Final_Direct <- Final_Direct[!(duplicated(Final_Direct$`Order Id`))]
Final_Direct <- rbind(Final_Direct, Weird_Directs)
Final_Direct <- Final_Direct[!(duplicated(Final_Direct$`Order Id`))]

direct2 <- data[data$`Product: Product Name` %in% membership_list & !(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) 
                & data$`Total Payment` < data$`Unit Price` & data$`Total Payment` != 0]

Final_Direct <- rbind(Final_Direct, direct2)
Final_Direct <- Final_Direct[!(duplicated(Final_Direct$`Order Id`))]

##########################################################################################################
#Indirect OTP

OTP_indirect1 <- data[(duplicated(data$`Order Id`) | duplicated(data$`Order Id`, fromLast = TRUE)) & data$`Unit Price` == 0 & data$`Total Payment` == 0]


Final_OTP <- OTP_indirect1[OTP_indirect1$`Product: Product Name` %in% membership_list]
Final_OTP <- rbind(Final_OTP, Weird_OTPs)
Final_OTP <- Final_OTP[!(duplicated(Final_OTP$`Order Id`))]

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

findem1 <- Weird_OTPs$`Order Id`
findem2 <- Weird_Directs$`Order Id`

notinbundle2 <- bundle2[!(bundle2$`Order Id` %in% findem1 | bundle2$`Order Id` %in% findem2)]

Final_Bundle <- rbind(bundle1, notinbundle2)
Final_Bundle <- Final_Bundle[(!(duplicated(Final_Bundle$`Order Id`)))]


canwefindem <- bind_rows(Final_Direct, Final_OTP, Final_Comp, Final_Bundle)

listed5 <- canwefindem$`Order Id`
here <- kindasus[kindasus$`Order Id` %notin% listed5]

Final_Comp <- rbind(Final_Comp, here)

#Write out our final tables
fwrite(Final_Direct, './UNH_Membership_Project/project/volume/data/processed/Final_Direct.csv')
fwrite(Final_OTP, './UNH_Membership_Project/project/volume/data/processed/Final_OTP.csv')
fwrite(Final_Comp, './UNH_Membership_Project/project/volume/data/processed/Final_Comp.csv')
fwrite(Final_Bundle, './UNH_Membership_Project/project/volume/data/processed/Final_Bundle.csv')




