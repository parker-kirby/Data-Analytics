library(ggplot2)
library(tidyr)

rates <- fread('./UNH_Membership_Project/project/volume/data/processed/rates.csv')

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
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6, hjust=0.5)) +
  facet_grid(~type) +
  geom_text(aes(label=round(value, digits = 1)), size = 2.5, position=position_dodge(width=0.9), vjust=-0.5)

           