#Read in our final tables

Final_Direct <- fread('./UNH_Membership_Project/project/volume/data/processed/Final_Direct.csv')
Final_OTP <- fread('./UNH_Membership_Project/project/volume/data/processed/Final_OTP.csv')
Final_Comp <- fread('./UNH_Membership_Project/project/volume/data/processed/Final_Comp.csv')
Final_Bundle <- fread('./UNH_Membership_Project/project/volume/data/processed/Final_Bundle.csv')

Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2016-01-01') & Final_Direct$`Transaction Date` <= as.Date('2016-12-31')] <- "2016"
Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2017-01-01') & Final_Direct$`Transaction Date` <= as.Date('2017-12-31')] <- "2017"
Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2018-01-01') & Final_Direct$`Transaction Date` <= as.Date('2018-12-31')] <- "2018"
Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2019-01-01') & Final_Direct$`Transaction Date` <= as.Date('2019-12-31')] <- "2019"
Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2020-01-01') & Final_Direct$`Transaction Date` <= as.Date('2020-12-31')] <- "2020"
Final_Direct$year[Final_Direct$`Transaction Date` >= as.Date('2021-01-01') & Final_Direct$`Transaction Date` <= as.Date('2021-12-31')] <- "2021"

Direct_yearly = dcast(Final_Direct, `Unique ID` ~ year)
