test <- fread('./UNH_Membership_Project/project/volume/data/raw/test (2).csv')

test2 <- test[duplicated(test$ID) | duplicated(test$ID, fromLast = TRUE)]

test3 <- test2[duplicated(test2$Year) | duplicated(test2$Year, fromLast = TRUE)]

test <- test[(duplicated(test$Year) | duplicated(test$Year, fromLast = TRUE))]

test <- test[duplicated(test$ID) & duplicated(test$Year)]
