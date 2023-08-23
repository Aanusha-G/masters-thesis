primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)

attach(primary_data)
n= length(primary_data$File)
MOA = primary_data$MOA
POA<-factor(POA)

sing=vector(mode="logical", length=0)
voiced =vector(mode="logical", length=0)
for (i in 1:n){
  s= grepl("_", MOA[i])
  v = grepl("VS",MOA[i])
  sing=append(sing,s,after=length(sing))
  voiced=append(voiced,v,after=length(voiced))
}

singleton<-factor(sing)
voicing<-factor(voiced)
dur<-Burst.Duration
data<-data.frame(dur, singleton, voicing)
aov = aov(dur~singleton*voicing,data=data)
summary(aov)

  ------------------------------------------  
plot_data<-data
plot_data$mean <- with(plot_data,ave(dur,singleton,voicing,FUN=mean))
plot.model <- lm(dur ~ voicing, data=plot_data)

outcome1 <- predict(plot.model,se.fit=TRUE)
plot_data$CI.half <- outcome1$se / 2

plot_data$gemination <- factor(plot_data$singleton,
                               levels = c(T,F),
                               labels = c("Singleton", "Geminate"))

plot_data$voicing<-factor(plot_data$voicing,
                          levels = c(T,F),
                          labels = c("Voiced", "Voiceless"))
summary.plotdata <- data.frame(
  Means = plot_data$mean,
  Gemination = plot_data$gemination,
  Voicing = plot_data$voicing,
  CI.half = plot_data$CI.half
)

library(ggplot2)

ggplot(data=summary.plotdata, aes(x=Voicing, y=Means, group=Gemination,color=Gemination,shape=Gemination)) +
  geom_line(size=0.8) +
  geom_errorbar(aes(ymin=Means-CI.half,ymax=Means+CI.half,), width=.1)+
  geom_point(size=3.5) +
  scale_colour_hue(l=50) +
  ylab("Average Burst Duration (ms)")+
  theme_bw() +
  guides(fill=FALSE)+  
  theme(axis.title.x=element_blank())+
  ggtitle("Variation of burst duration with voicing and gemination")
