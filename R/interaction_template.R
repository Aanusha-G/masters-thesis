island.1 <- c(0.2, 5.9, 6.1, 6.5)
island.2 <- c(5.6, 14.8, 15.5, 16.4)
island.3 <- c(0.8, 3.9, 4.3, 4.9)
sex.codes <- c("Male", "Female", "Male", "Female")

df.1 <- data.frame(island.1, island.2, island.3, sex.codes)

#   MELTING THE DATA FRAME INTO LONG FORM
library(reshape)
df.2 <- melt(df.1)
df.2$mean <- with(df.2,ave(value,sex.codes,variable,FUN=mean))
lizard.model <- lm(value ~ variable*sex.codes, data=df.2)
lizard.anova <- anova(lizard.model)
fitted(lizard.model)

outcome <- predict(lizard.model,se.fit=TRUE)
df.2$CI.half <- outcome$se / 2
summary.df <- data.frame(
  Means = df.2$mean,
  Location = df.2$variable,
  Sex = df.2$sex.codes,      
  CI.half = df.2$CI.half
)

library(ggplot2)
qplot(data=summary.df,
      y=Means,
      x=Location,
      group=Sex,
      ymin=Means-CI.half,
      ymax=Means+CI.half,
      geom=c("point", "errorbar", "line"),
      color=Sex,
      shape=Sex,
      width=0.25) + theme_bw()
