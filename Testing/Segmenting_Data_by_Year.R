library(data.table)

data <- fread('./UNH_Membership_Project/project/volume/data/raw/raw_data.csv')

data$`Transaction Date` <- as.Date(data$`Transaction Date`, "%m/%d/%Y")

data <- data[data$`Transaction Date` < as.Date('2022-01-01')]

2016 <- data[data$`Transaction Date` >= as.Date('2016-01-01') & data$`Transaction Date` < as.Date('2017-01-01')]
2017 <- data[data$`Transaction Date` >= as.Date('2017-01-01') & data$`Transaction Date` < as.Date('2018-01-01')]
2018 <- data[data$`Transaction Date` >= as.Date('2018-01-01') & data$`Transaction Date` < as.Date('2019-01-01')]
2019 <- data[data$`Transaction Date` >= as.Date('2019-01-01') & data$`Transaction Date` < as.Date('2020-01-01')]
2020 <- data[data$`Transaction Date` >= as.Date('2020-01-01') & data$`Transaction Date` < as.Date('2021-01-01')]
2021 <- data[data$`Transaction Date` >= as.Date('2021-01-01') & data$`Transaction Date` < as.Date('2022-01-01')]

fwrite(2016, './UNH_Membership_Project/project/volume/data/interim/2016_data.csv')
fwrite(2017, './UNH_Membership_Project/project/volume/data/interim/2017_data.csv')
fwrite(2018, './UNH_Membership_Project/project/volume/data/interim/2018_data.csv')
fwrite(2019, './UNH_Membership_Project/project/volume/data/interim/2019_data.csv')
fwrite(2020, './UNH_Membership_Project/project/volume/data/interim/2020_data.csv')
fwrite(2021, './UNH_Membership_Project/project/volume/data/interim/2021_data.csv')