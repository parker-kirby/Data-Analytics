
data <- fread('./Brazil_Project/project/volume/data/interim/cleaned_data.csv')


keep <- c("Email", "Campaign Name", "New", "Successful Lead", "Days Between", "Account Owner", "Country (text only)")

Final <- data[, keep, with=FALSE]

Final <- Final[!duplicated(Final$Email)]

Final <- Final[Final$New == 1]

fwrite(Final, './Brazil_Project/project/volume/data/processed/reformated.csv')
