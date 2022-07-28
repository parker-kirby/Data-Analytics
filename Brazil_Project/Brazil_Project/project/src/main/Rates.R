Final <- fread('./Brazil_Project/project/volume/data/processed/reformated.csv')

#Rates of campaigns
CDPO <- Final[Final$`Campaign Name` == 'CDPO Brazil RSVP']
CDPO_Rate <- (sum(CDPO$`Successful Lead`)/sum(CDPO$New)) * 100

PPC_CIPM <- Final[Final$`Campaign Name` == 'PPC_CIPM _BRAZIL_FreeStudyGuide']
PPC_CIPM_Rate <- (sum(PPC_CIPM$`Successful Lead`)/sum(PPC_CIPM$New)) * 100

CIPM <- Final[Final$`Campaign Name` == 'CIPM FSG Brazil LinkedIn']
CIPM_Rate <- (sum(CIPM$`Successful Lead`)/sum(CIPM$New)) * 100

LI_CIPM <- Final[Final$`Campaign Name` == 'LI_CIPM_BRAZIL _FreeStudyGuide']
LI_CIPM_Rate <- (sum(LI_CIPM$`Successful Lead`)/sum(LI_CIPM$New)) * 100

CIPM_FSG <- Final[Final$`Campaign Name` == 'CIPM FSG Brazil']     
CIPM_FSG_Rate <- (sum(CIPM_FSG$`Successful Lead`)/sum(CIPM_FSG$New)) * 100

Total_Rate <- (sum(Final$`Successful Lead`)/sum(Final$New)) * 100

rates <- bind_cols(CDPO_Rate, PPC_CIPM_Rate, CIPM_Rate, LI_CIPM_Rate, CIPM_FSG_Rate, Total_Rate)
colnames(rates) <- c('CDPO Brazil RSVP', 'PPC_CIPM _BRAZIL_FreeStudyGuide',
                     'CIPM FSG Brazil LinkedIn', 'LI_CIPM_BRAZIL _FreeStudyGuide',
                     'CIPM FSG Brazil', 'Total')

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

fwrite(rates, './Sales_Project/project/volume/data/processed/rates.csv')
fwrite(average_days, './Sales_Project/project/volume/data/processed/average_days.csv')