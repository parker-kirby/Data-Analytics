library(poLCA)
set.seed(17)

data <- fread('./Sales_Project/project/volume/data/interim/cleaned_data.csv')

poLCA(cbind(indicator1, indicator2, indicator3)~1, data=mydata)