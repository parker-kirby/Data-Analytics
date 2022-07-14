#Read in our final tables

Final_Direct <- fread('./UNH_Membership_Project/project/volume/data/processed/Final_Direct.csv')
Final_OTP <- fread('./UNH_Membership_Project/project/volume/data/processed/Final_OTP.csv')
Final_Comp <- fread('./UNH_Membership_Project/project/volume/data/processed/Final_Comp.csv')
Final_Bundle <- fread('./UNH_Membership_Project/project/volume/data/processed/Final_Bundle.csv')

Final_Direct$num <- 1
Final_OTP$num <- 2
Final_Comp$num <- 3
Final_Bundle$num <- 4

#Adding year of transaction to Final_Direct
Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2016-01-01') & Final_Direct$`Transaction Date` <= as.Date('2016-12-31')] <- "2016"
Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2017-01-01') & Final_Direct$`Transaction Date` <= as.Date('2017-12-31')] <- "2017"
Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2018-01-01') & Final_Direct$`Transaction Date` <= as.Date('2018-12-31')] <- "2018"
Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2019-01-01') & Final_Direct$`Transaction Date` <= as.Date('2019-12-31')] <- "2019"
Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2020-01-01') & Final_Direct$`Transaction Date` <= as.Date('2020-12-31')] <- "2020"
Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2021-01-01') & Final_Direct$`Transaction Date` <= as.Date('2021-12-31')] <- "2021"

#Adding year of transaction to Final_OTP
Final_OTP$year[Final_OTP$`Transaction Date` >= as.Date('2016-01-01') & Final_OTP$`Transaction Date` <= as.Date('2016-12-31')] <- "2016"
Final_OTP$year[Final_OTP$`Transaction Date` >= as.Date('2017-01-01') & Final_OTP$`Transaction Date` <= as.Date('2017-12-31')] <- "2017"
Final_OTP$year[Final_OTP$`Transaction Date` >= as.Date('2018-01-01') & Final_OTP$`Transaction Date` <= as.Date('2018-12-31')] <- "2018"
Final_OTP$year[Final_OTP$`Transaction Date` >= as.Date('2019-01-01') & Final_OTP$`Transaction Date` <= as.Date('2019-12-31')] <- "2019"
Final_OTP$year[Final_OTP$`Transaction Date` >= as.Date('2020-01-01') & Final_OTP$`Transaction Date` <= as.Date('2020-12-31')] <- "2020"
Final_OTP$year[Final_OTP$`Transaction Date` >= as.Date('2021-01-01') & Final_OTP$`Transaction Date` <= as.Date('2021-12-31')] <- "2021"

#Adding year of transaction to Final_Comp
Final_Comp$year[Final_Comp$`Transaction Date` >= as.Date('2016-01-01') & Final_Comp$`Transaction Date` <= as.Date('2016-12-31')] <- "2016"
Final_Comp$year[Final_Comp$`Transaction Date` >= as.Date('2017-01-01') & Final_Comp$`Transaction Date` <= as.Date('2017-12-31')] <- "2017"
Final_Comp$year[Final_Comp$`Transaction Date` >= as.Date('2018-01-01') & Final_Comp$`Transaction Date` <= as.Date('2018-12-31')] <- "2018"
Final_Comp$year[Final_Comp$`Transaction Date` >= as.Date('2019-01-01') & Final_Comp$`Transaction Date` <= as.Date('2019-12-31')] <- "2019"
Final_Comp$year[Final_Comp$`Transaction Date` >= as.Date('2020-01-01') & Final_Comp$`Transaction Date` <= as.Date('2020-12-31')] <- "2020"
Final_Comp$year[Final_Comp$`Transaction Date` >= as.Date('2021-01-01') & Final_Comp$`Transaction Date` <= as.Date('2021-12-31')] <- "2021"

#Adding year of transaction to Final_Bundle
Final_Bundle$year[Final_Bundle$`Transaction Date` >= as.Date('2016-01-01') & Final_Bundle$`Transaction Date` <= as.Date('2016-12-31')] <- "2016"
Final_Bundle$year[Final_Bundle$`Transaction Date` >= as.Date('2017-01-01') & Final_Bundle$`Transaction Date` <= as.Date('2017-12-31')] <- "2017"
Final_Bundle$year[Final_Bundle$`Transaction Date` >= as.Date('2018-01-01') & Final_Bundle$`Transaction Date` <= as.Date('2018-12-31')] <- "2018"
Final_Bundle$year[Final_Bundle$`Transaction Date` >= as.Date('2019-01-01') & Final_Bundle$`Transaction Date` <= as.Date('2019-12-31')] <- "2019"
Final_Bundle$year[Final_Bundle$`Transaction Date` >= as.Date('2020-01-01') & Final_Bundle$`Transaction Date` <= as.Date('2020-12-31')] <- "2020"
Final_Bundle$year[Final_Bundle$`Transaction Date` >= as.Date('2021-01-01') & Final_Bundle$`Transaction Date` <= as.Date('2021-12-31')] <- "2021"


#if account ID and year of record is the same, then only keep record with lower Order ID number
#trying to fix the problem where a customer bought multiple memberships in a year

merged <- bind_rows(Final_Direct, Final_OTP, Final_Comp, Final_Bundle)

merged[merged$`Order Id` == "Order 1336141"]

setorder(merged, cols = `Order Id`)

merged <- as.data.frame(merged)

merged <- merged[!duplicated(merged[c('Unique ID', 'year')]),]

merged <- as.data.table(merged)

merged$year<- as.numeric(merged$year)


#Separate table back into Direct, OTP, Comp, or Bundle
Final_Direct <- merged[merged$num == 1]
Final_OTP <- merged[merged$num == 2]
Final_Comp <- merged[merged$num == 3]
Final_Bundle <- merged[merged$num == 4]
Final_Direct <- Final_Direct[, 'num':=NULL]
Final_OTP <- Final_OTP[, 'num':=NULL]
Final_Comp <- Final_Comp[, 'num':=NULL]
Final_Bundle <- Final_Bundle[, 'num':=NULL]


##############
#Direct Yearly
Direct_yearly = dcast(Final_Direct, `Unique ID` ~ year)

Direct_yearly <- Direct_yearly[,"NA":=NULL]

for(j in 2:ncol(Direct_yearly)){
  set(Direct_yearly, i= which(Direct_yearly[[j]]!=0), j=j, value =1)
}

###########
#OTP Yearly
OTP_yearly = dcast(Final_OTP, `Unique ID` ~ year)

OTP_yearly <- OTP_yearly[,"NA":=NULL]

for(j in 2:ncol(OTP_yearly)){
  set(OTP_yearly, i= which(OTP_yearly[[j]]!=0), j=j, value =2)
}

Total_yearly<-rbind(Direct_yearly, OTP_yearly)

############
#Comp Yearly
Comp_yearly = dcast(Final_Comp, `Unique ID` ~ year)

Comp_yearly <- Comp_yearly[,"NA":=NULL]

for(j in 2:ncol(Comp_yearly)){
  set(Comp_yearly, i= which(Comp_yearly[[j]]!=0), j=j, value =3)
}

Total_yearly<-rbind(Total_yearly, Comp_yearly)

##############
#Bundle Yearly
Bundle_yearly = dcast(Final_Bundle, `Unique ID` ~ year)

Bundle_yearly <- Bundle_yearly[,"NA":=NULL]

for(j in 2:ncol(Bundle_yearly)){
  set(Bundle_yearly, i= which(Bundle_yearly[[j]]!=0), j=j, value =4)
}

Total_yearly<-rbind(Total_yearly, Bundle_yearly)

#Creating Total_yearly which holds all information about when each customer bought membership and what type of membership the bought 
#(direct, OTP, Comp, or Bundle)

Total_yearly[is.na(Total_yearly)] <- 0

Total_yearly <- Total_yearly[,.(`2016`=sum(`2016`), `2017`=sum(`2017`), `2018`=sum(`2018`), `2019`=sum(`2019`), `2020`=sum(`2020`), `2021`=sum(`2021`)), `Unique ID`]

fwrite(Total_yearly, './UNH_Membership_Project/project/volume/data/processed/Total_yearly.csv')
