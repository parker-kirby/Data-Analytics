library(ggplot2)
library(tidyr)

rates <- fread('./UNH_Membership_Project/project/volume/data/processed/rates.csv')
members <- fread('./UNH_Membership_Project/project/volume/data/processed/members.csv')

rownames(rates) <- c("General", "Direct", "OTP", "Comp", "Bundle")
names <- rownames(rates)
rownames(rates) <- NULL
rates <- cbind(names, rates)
rates <- rates[-1, ]

data <- gather(rates, type, value, -names) 

ggplot(data, aes(reorder(names, -value), value, fill = names)) + 
  geom_bar(stat = "identity", width = 0.85, color = "black", position = "dodge") +
  scale_fill_brewer(palette = "Set2") +
  theme() +
  ylim(0, 100) +
  xlab("Year") +
  ylab("Retention Rate") +
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6, hjust=0.5, size = 12)) +
  facet_grid(~type) +
  geom_text(aes(label=round(value, digits = 1)), size = 4, position=position_dodge(width=0.9), vjust=-0.5)

rownames(members) <- c("Direct", "OTP", "Comp", "Bundle")
names <- rownames(members)
rownames(members) <- NULL
members <- cbind(names, members)

data2 <- gather(members, type, value, -names) 

ggplot(data2, aes(reorder(names, -value), value, fill = names)) + 
  geom_bar(stat = "identity", width = 0.85, color = "black", position = "dodge") +
  scale_fill_brewer(palette = "Set2") +
  theme() +
  ylim(0, 100) +
  xlab("Year") +
  ylab("Retention Rate") +
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6, hjust=0.5)) +
  facet_grid(~type) +
  geom_text(aes(label=round(value, digits = 1)), size = 2.5, position=position_dodge(width=0.9), vjust=-0.5)


rates <- rates[, -1]
members <- members[, -1]

as.matrix(rates)
as.matrix(members)

Map <- rates*members

sum_2017 <- sum(Map$`2017 Rate`)
sum_2018 <- sum(Map$`2018 Rate`)
sum_2019 <- sum(Map$`2019 Rate`)
sum_2020 <- sum(Map$`2020 Rate`)
sum_2021 <- sum(Map$`2021 Rate`)

new <- as.data.frame(((Map$`2017 Rate`/sum_2017)*100))
new$`2018` <- ((Map$`2018 Rate`/sum_2018)*100)
new$`2019` <- ((Map$`2019 Rate`/sum_2019)*100)
new$`2020` <- ((Map$`2020 Rate`/sum_2020)*100)
new$`2021` <- ((Map$`2021 Rate`/sum_2021)*100)
colnames(new) <- c("2017", "2018", "2019", "2020", "2021")

as.data.frame(new)
rownames(new) <- c("Direct", "OTP", "Comp", "Bundle")
names <- rownames(new)
rownames(new) <- NULL
new <- cbind(names, new)

data3 <- gather(new, type, value, -names) 

ggplot(data3, aes(reorder(names, -value), value, fill = names)) + 
  geom_bar(stat = "identity", width = 0.85, color = "black", position = "dodge") +
  scale_fill_brewer(palette = "Set2") +
  theme() +
  ylim(0, 100) +
  xlab("Year") +
  ylab("Retention Rate * Population Percentage") +
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6, hjust=0.5)) +
  facet_grid(~type) +
  geom_text(aes(label=round(value, digits = 1)), size = 2.5, position=position_dodge(width=0.9), vjust=-0.5)
