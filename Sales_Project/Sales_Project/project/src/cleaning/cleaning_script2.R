library(data.table)
library(dplyr)
library(carat)

#read in our data
data <- fread('./Sales_Project/project/volume/data/raw/raw_data.csv')

'%notin%' <- Negate('%in%')

remove <- c( "Member Status Update Date", "Member First Responded Date", 
             "Designation", "Account Name", "Member")
data <- data[, remove:=NULL, with=FALSE]

data[is.na(data)] <- "none"
data[is.null(data)] <- "none"
data[data == ""] <- "none"

#Converting date formats and specifying our date range
data$`Member First Associated Date` <- as.Date(data$`Member First Associated Date`, "%m/%d/%Y")
data$`Transaction Date` <- as.Date(data$`Transaction Date`, "%m/%d/%Y")
data$`Account Created Date` <- as.Date(data$`Account Created Date`, "%m/%d/%Y")

no_transaction <- data$Email[is.na(data$`Transaction Date`)]

###############################################
#Testing

testing <- data[data$`Order Id` == "Order 0060791"]
testing <- data[data$`Email` == "sm.brosig@gmail.com"]

finding <- data[data$New == 1 & data$`Successful Lead` == 0]
finding2 <- data[data$New == 1 & data$`Successful Lead` == 1]

###############################################

#New Columns
######################################
#NEW
data$New[data$`Transaction Date` < data$`Member First Associated Date`] <- 0
not_new <- data$Email[data$New == 0]
data$New[data$Email %in% no_transaction & data$Email %notin% not_new] <- 1
data$New[data$`Transaction Date` >= data$`Member First Associated Date` & data$Email %notin% not_new] <- 1
data$New[data$Email %in% not_new] <- 0

#SUCCESSFUL LEAD
data$`Successful Lead`[data$`Member First Associated Date` <= data$`Transaction Date` & data$New == 1 & data$Email %notin% no_transaction] <- 1
data$`Successful Lead`[data$New == 1 & data$Email %in% no_transaction] <- 0
data$`Successful Lead`[data$New == 0] <- 0

data <- data[data$`Product: Category` != "White Paper"]
data <- data[data$`Product: Record Type` != "Coupon"]
data <- data[data$`Account Money Spent` != 0]
data <- data[data$`Product: Category` != "ebook"]
data <- data[data$`Product: Category` != "Book"]

#NUMBER OF TRANSACTIONS
data$placeholder <- 1
num_transactions <- data[(duplicated(data$Email) | duplicated(data$Email, fromLast = TRUE))]
num_transactions <- num_transactions[!(duplicated(num_transactions$`Order Id`))]
num_transactions <- tapply(num_transactions$placeholder, num_transactions$Email, sum)
num_transactions <- as.data.frame(num_transactions)
d <- num_transactions
names <- rownames(d)
rownames(d) <- NULL
num_transactions <- cbind(names, d)
data <- merge(data, num_transactions, by.x = 'Email', by.y = 'names', all = TRUE)
data$num_transactions[is.na(data$num_transactions)] <- 0

#AVERAGE TRANSACTION COST
data$`Account Money Spent`[data$`Account Money Spent` == 'none'] <- 0
data$`Account Money Spent` <- as.numeric(data$`Account Money Spent`)
data$ave_tran_cost <- (data$`Account Money Spent`/data$num_transactions)
data$ave_tran_cost[data$num_transactions == 0] <- 0
data$ave_tran_cost <- round(data$ave_tran_cost, 2)

#NUMBER OF ITEMS IN ORDER
num_items <- data[(duplicated(data$`Order Id`) | duplicated(data$Email, fromLast = TRUE))]
num_items <- tapply(num_items$placeholder, num_items$`Order Id`, sum)
num_items <- as.data.frame(num_items)
d <- num_items
names <- rownames(d)
rownames(d) <- NULL
num_items <- cbind(names, d)
data <- merge(data, num_items, by.x = 'Order Id', by.y = 'names', all = TRUE)
data$num_items[is.na(data$num_items)] <- 0
data$num_items[data$num_items > 100] <- 0

#AVERAGE UNIT PRICE
data$`Total Payment` <- as.numeric(data$`Total Payment`)
data$ave_unit_price <- (data$`Total Payment`/data$num_items)
data$ave_unit_price <- round(data$ave_unit_price, 2)

#DAYS BETWEEN
data$`Days Between` <- difftime(data$`Transaction Date`, data$`Member First Associated Date`, units = 'days')
data$placeholder <- NULL

seeing <- data[data$New ==1 & data$`Successful Lead` == 0]

fwrite(data, './Sales_Project/project/volume/data/interim/cleaned_data.csv')
