
Final <- fread('./Sales_Project/project/volume/data/processed/reformated.csv')

#Rates of campaigns
RSA <- Final[Final$`Campaign Name` == 'RSA 2019 Booth Visitors']
RSA_Rate <- (sum(RSA$`Successful Lead`)/sum(RSA$New)) * 100

InfoSec <- Final[Final$`Campaign Name` == 'InfoSec LinkedIn LeadGen 2019']
InfoSec_Rate <- (sum(InfoSec$`Successful Lead`)/sum(InfoSec$New)) * 100

Markerting <- Final[Final$`Campaign Name` == 'Marketing LinkedIn LeadGen']
Markerting_Rate <- (sum(Markerting$`Successful Lead`)/sum(Markerting$New)) * 100

Mind_Gap <- Final[Final$`Campaign Name` == 'Mind The Gaps Campaign']
Mind_Gap_Rate <- (sum(Mind_Gap$`Successful Lead`)/sum(Mind_Gap$New)) * 100

Summit <- Final[Final$`Campaign Name` == 'Summit 2019 Booth Scans']     
Summit_Rate <- (sum(Summit$`Successful Lead`)/sum(Summit$New)) * 100

Total_Rate <- (sum(Final$`Successful Lead`)/sum(Final$New)) * 100

rates <- bind_cols(RSA_Rate, InfoSec_Rate, Markerting_Rate, Mind_Gap_Rate, Summit_Rate, Total_Rate)
colnames(rates) <- c('RSA', 'InfoSec', 'Marketing', 'Mind_Gap', 'Summit', 'Total')

sum(Final$`Successful Lead`)
bobby <- Final[Final$`Successful Lead` == 1]

#Rates for Account Owners
account_owner_suc <- tapply(Final$`Successful Lead`, Final$`Account Owner`, sum)
account_owner_suc <- as.data.frame(account_owner_suc)
account_owner_total <- tapply(Final$New, Final$`Account Owner`, sum)
account_owner_total <- as.data.frame(account_owner_total)

account_owner_rates <- cbind(account_owner_suc, account_owner_total)
colnames(account_owner_rates) <- c("successful", "num new leads")
d <- account_owner_rates
names <- rownames(d)
rownames(d) <- NULL
account_owner_rates <- cbind(names, d)
account_owner_rates$rate <- (account_owner_rates$successful/account_owner_rates$`num new leads`) * 100

#Rates for Countries
country <- Final[Final$`Country (text only)` != 'none']
country_suc <- tapply(country$`Successful Lead`, country$`Country (text only)`, sum)
country_suc <- as.data.frame(country_suc)
country_total <- tapply(country$New, country$`Country (text only)`, sum)
country_total <- as.data.frame(country_total)

country_rates <- cbind(country_suc, country_total)
colnames(country_rates) <- c("successful", "num new leads")
d <- country_rates
names <- rownames(d)
rownames(d) <- NULL
country_rates <- cbind(names, d)
country_rates$rate <- (country_rates$successful/country_rates$`num new leads`) * 100

#Average days between entering campaign and purchase
average_days <- Final[Final$`Days Between` >= 0]

average_days <- tapply(average_days$`Days Between`, average_days$`Campaign Name`, mean)
average_days <- as.data.frame(average_days)
colnames(average_days) <- "Average Days Between"
d <- average_days
names <- rownames(d)
rownames(d) <- NULL
average_days <- cbind(names, d)

average_days_total <- Final[Final$`Days Between` >= 0]
average_days_total <- as.data.frame(cbind("Total Average", mean(average_days_total$`Days Between`)))
colnames(average_days_total) <- c("names", "Average Days Between")
average_days <- rbind(average_days, average_days_total)

fwrite(account_owner_rates, './Sales_Project/project/volume/data/processed/account_owner_rates.csv')
fwrite(average_days, './Sales_Project/project/volume/data/processed/average_days.csv')
fwrite(country_rates, './Sales_Project/project/volume/data/processed/country_rates.csv')
fwrite(rates, './Sales_Project/project/volume/data/processed/rates.csv')
