Total_yearly <- fread('./UNH_Membership_Project/project/volume/data/processed/Total_yearly.csv')

######################################################
#General Rate


general_members_2016 <- sum(Total_yearly$`2016` > 0)
general_members_2017 <- sum(Total_yearly$`2017` > 0)
general_members_2018 <- sum(Total_yearly$`2018` > 0)
general_members_2019 <- sum(Total_yearly$`2019` > 0)
general_members_2020 <- sum(Total_yearly$`2020` > 0)
general_members_2021 <- sum(Total_yearly$`2021` > 0)
  
general_retention_2017 <- sum(Total_yearly$`2016` > 0 & Total_yearly$`2017` > 0)
general_retention_2018 <- sum(Total_yearly$`2017` > 0 & Total_yearly$`2018` > 0)
general_retention_2019 <- sum(Total_yearly$`2018` > 0 & Total_yearly$`2019` > 0)
general_retention_2020 <- sum(Total_yearly$`2019` > 0 & Total_yearly$`2020` > 0)
general_retention_2021 <- sum(Total_yearly$`2020` > 0 & Total_yearly$`2021` > 0)

general_rates <- as.data.table(((general_retention_2017/general_members_2016) * 100))
colnames(general_rates) <- "2017 Rate"
general_rates$`2018 Rate` <- ((general_retention_2018/general_members_2017) * 100)
general_rates$`2019 Rate` <- ((general_retention_2019/general_members_2018) * 100)
general_rates$`2020 Rate` <- ((general_retention_2020/general_members_2019) * 100)
general_rates$`2021 Rate` <- ((general_retention_2021/general_members_2020) * 100)

######################################################
#Direct Rate
Direct_members_2016 <- sum(Total_yearly$`2016` == 1)
Direct_members_2017 <- sum(Total_yearly$`2017` == 1)
Direct_members_2018 <- sum(Total_yearly$`2018` == 1)
Direct_members_2019 <- sum(Total_yearly$`2019` == 1)
Direct_members_2020 <- sum(Total_yearly$`2020` == 1)
Direct_members_2021 <- sum(Total_yearly$`2021` == 1)

Direct_retention_2017 <- sum(Total_yearly$`2016` == 1 & Total_yearly$`2017` > 0)
Direct_retention_2018 <- sum(Total_yearly$`2017` == 1 & Total_yearly$`2018` > 0)
Direct_retention_2019 <- sum(Total_yearly$`2018` == 1 & Total_yearly$`2019` > 0)
Direct_retention_2020 <- sum(Total_yearly$`2019` == 1 & Total_yearly$`2020` > 0)
Direct_retention_2021 <- sum(Total_yearly$`2020` == 1 & Total_yearly$`2021` > 0)

Direct_rates <- as.data.table(((Direct_retention_2017/Direct_members_2016) * 100))
colnames(Direct_rates) <- "2017 Rate"
Direct_rates$`2018 Rate` <- ((Direct_retention_2018/Direct_members_2017) * 100)
Direct_rates$`2019 Rate` <- ((Direct_retention_2019/Direct_members_2018) * 100)
Direct_rates$`2020 Rate` <- ((Direct_retention_2020/Direct_members_2019) * 100)
Direct_rates$`2021 Rate` <- ((Direct_retention_2021/Direct_members_2020) * 100)


######################################################
#OTP Rate
OTP_members_2016 <- sum(Total_yearly$`2016` == 2)
OTP_members_2017 <- sum(Total_yearly$`2017` == 2)
OTP_members_2018 <- sum(Total_yearly$`2018` == 2)
OTP_members_2019 <- sum(Total_yearly$`2019` == 2)
OTP_members_2020 <- sum(Total_yearly$`2020` == 2)
OTP_members_2021 <- sum(Total_yearly$`2021` == 2)

OTP_retention_2017 <- sum(Total_yearly$`2016` == 2 & Total_yearly$`2017` > 0)
OTP_retention_2018 <- sum(Total_yearly$`2017` == 2 & Total_yearly$`2018` > 0)
OTP_retention_2019 <- sum(Total_yearly$`2018` == 2 & Total_yearly$`2019` > 0)
OTP_retention_2020 <- sum(Total_yearly$`2019` == 2 & Total_yearly$`2020` > 0)
OTP_retention_2021 <- sum(Total_yearly$`2020` == 2 & Total_yearly$`2021` > 0)

OTP_rates <- as.data.table(((OTP_retention_2017/OTP_members_2016) * 100))
colnames(OTP_rates) <- "2017 Rate"
OTP_rates$`2018 Rate` <- ((OTP_retention_2018/OTP_members_2017) * 100)
OTP_rates$`2019 Rate` <- ((OTP_retention_2019/OTP_members_2018) * 100)
OTP_rates$`2020 Rate` <- ((OTP_retention_2020/OTP_members_2019) * 100)
OTP_rates$`2021 Rate` <- ((OTP_retention_2021/OTP_members_2020) * 100)

######################################################
#Comp Rate
Comp_members_2016 <- sum(Total_yearly$`2016` == 3)
Comp_members_2017 <- sum(Total_yearly$`2017` == 3)
Comp_members_2018 <- sum(Total_yearly$`2018` == 3)
Comp_members_2019 <- sum(Total_yearly$`2019` == 3)
Comp_members_2020 <- sum(Total_yearly$`2020` == 3)
Comp_members_2021 <- sum(Total_yearly$`2021` == 3)

Comp_retention_2017 <- sum(Total_yearly$`2016` == 3 & Total_yearly$`2017` > 0)
Comp_retention_2018 <- sum(Total_yearly$`2017` == 3 & Total_yearly$`2018` > 0)
Comp_retention_2019 <- sum(Total_yearly$`2018` == 3 & Total_yearly$`2019` > 0)
Comp_retention_2020 <- sum(Total_yearly$`2019` == 3 & Total_yearly$`2020` > 0)
Comp_retention_2021 <- sum(Total_yearly$`2020` == 3 & Total_yearly$`2021` > 0)

Comp_rates <- as.data.table(((Comp_retention_2017/Comp_members_2016) * 100))
colnames(Comp_rates) <- "2017 Rate"
Comp_rates$`2018 Rate` <- ((Comp_retention_2018/Comp_members_2017) * 100)
Comp_rates$`2019 Rate` <- ((Comp_retention_2019/Comp_members_2018) * 100)
Comp_rates$`2020 Rate` <- ((Comp_retention_2020/Comp_members_2019) * 100)
Comp_rates$`2021 Rate` <- ((Comp_retention_2021/Comp_members_2020) * 100)

######################################################
#Bundle Rate
Bundle_members_2016 <- sum(Total_yearly$`2016` == 4)
Bundle_members_2017 <- sum(Total_yearly$`2017` == 4)
Bundle_members_2018 <- sum(Total_yearly$`2018` == 4)
Bundle_members_2019 <- sum(Total_yearly$`2019` == 4)
Bundle_members_2020 <- sum(Total_yearly$`2020` == 4)
Bundle_members_2021 <- sum(Total_yearly$`2021` == 4)

Bundle_retention_2017 <- sum(Total_yearly$`2016` == 4 & Total_yearly$`2017` > 0)
Bundle_retention_2018 <- sum(Total_yearly$`2017` == 4 & Total_yearly$`2018` > 0)
Bundle_retention_2019 <- sum(Total_yearly$`2018` == 4 & Total_yearly$`2019` > 0)
Bundle_retention_2020 <- sum(Total_yearly$`2019` == 4 & Total_yearly$`2020` > 0)
Bundle_retention_2021 <- sum(Total_yearly$`2020` == 4 & Total_yearly$`2021` > 0)

Bundle_rates <- as.data.table(((Bundle_retention_2017/Bundle_members_2016) * 100))
colnames(Bundle_rates) <- "2017 Rate"
Bundle_rates$`2018 Rate` <- ((Bundle_retention_2018/Bundle_members_2017) * 100)
Bundle_rates$`2019 Rate` <- ((Bundle_retention_2019/Bundle_members_2018) * 100)
Bundle_rates$`2020 Rate` <- ((Bundle_retention_2020/Bundle_members_2019) * 100)
Bundle_rates$`2021 Rate` <- ((Bundle_retention_2021/Bundle_members_2020) * 100)

##################
#Final Rates Table

rates <- bind_rows(general_rates, Direct_rates, OTP_rates, Comp_rates, Bundle_rates)
rates <- as.data.frame(rates)
rownames(rates) <- c("General", "Direct", "OTP", "Comp", "Bundle")
fwrite(rates, './UNH_Membership_Project/project/volume/data/processed/rates.csv')


######################
#Direct member numbers
Direct_members <- as.data.table((Direct_members_2017/general_members_2017) *100)
colnames(Direct_members) <- "2017 Member%"
Direct_members$`2018 Member%` <- ((Direct_members_2018/general_members_2018) *100)
Direct_members$`2019 Member%` <- ((Direct_members_2019/general_members_2019) *100)
Direct_members$`2020 Member%` <- ((Direct_members_2020/general_members_2020) *100)
Direct_members$`2021 Member%` <- ((Direct_members_2021/general_members_2021) *100)

######################
#OTP member numbers
OTP_members <- as.data.table((OTP_members_2017/general_members_2017) *100)
colnames(OTP_members) <- "2017 Member%"
OTP_members$`2018 Member%` <- ((OTP_members_2018/general_members_2018) *100)
OTP_members$`2019 Member%` <- ((OTP_members_2019/general_members_2019) *100)
OTP_members$`2020 Member%` <- ((OTP_members_2020/general_members_2020) *100)
OTP_members$`2021 Member%` <- ((OTP_members_2021/general_members_2021) *100)

#####################
#Comp member numbers
Comp_members <- as.data.table((Comp_members_2017/general_members_2017) *100)
colnames(Comp_members) <- "2017 Member%"
Comp_members$`2018 Member%` <- ((Comp_members_2018/general_members_2018) *100)
Comp_members$`2019 Member%` <- ((Comp_members_2019/general_members_2019) *100)
Comp_members$`2020 Member%` <- ((Comp_members_2020/general_members_2020) *100)
Comp_members$`2021 Member%` <- ((Comp_members_2021/general_members_2021) *100)

######################
#Bundle member numbers
Bundle_members <- as.data.table((Bundle_members_2017/general_members_2017) *100)
colnames(Bundle_members) <- "2017 Member%"
Bundle_members$`2018 Member%` <- ((Bundle_members_2018/general_members_2018) *100)
Bundle_members$`2019 Member%` <- ((Bundle_members_2019/general_members_2019) *100)
Bundle_members$`2020 Member%` <- ((Bundle_members_2020/general_members_2020) *100)
Bundle_members$`2021 Member%` <- ((Bundle_members_2021/general_members_2021) *100)

###################
#Membership numbers
members <- bind_rows(Direct_members, OTP_members, Comp_members, Bundle_members)
members <- as.data.frame(members)
rownames(members) <- c("Direct", "OTP", "Comp", "Bundle")
fwrite(members, './UNH_Membership_Project/project/volume/data/processed/members.csv')
