primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)

attach(primary_data)
n= length(primary_data$File)
MOA = primary_data$MOA
POA<-factor(POA)

sing=vector(mode="logical", length=0)
voiced =vector(mode="logical", length=0)
levels=c("BL","D","R","V")
V2_data=vector(mode="double",length=0)
poa_data=vector(length=0)
for (i in 1:n){
  s= grepl("_", MOA[i])
  v = grepl("VS",MOA[i])
  sing=append(sing,s,after=length(sing))
  voiced=append(voiced,v,after=length(voiced))
  V2_data=append(V2_data,V2.Dur[i],after=length(V2_data))
  poa_data=append(poa_data,POA[i],after=length(poa_data))
}

poa_data<-factor(poa_data)
data<-data.frame(V2_Dur=V2_data, singleton=sing, poa =poa_data, voicing=voiced)
aov = aov(V2_Dur~singleton*poa*voicing,data=data)
summary(aov)

gems<-data[which(data$singleton==FALSE),]
sings<-data[which(data$singleton==TRUE),]
gems$mean <- with(gems,ave(V2_Dur,poa,voicing,FUN=mean))
sings$mean <- with(sings,ave(V2_Dur,poa,voicing,FUN=mean))
gems.model <- lm(V2_Dur ~ poa*voicing, data=gems)
sings.model <- lm(V2_Dur ~ poa*voicing, data=sings)

outcome1 <- predict(gems.model,se.fit=TRUE)
gems$CI.half <- outcome1$se / 2

outcome2 <- predict(sings.model,se.fit=TRUE)
sings$CI.half <- outcome2$se / 2

gems$poa <- factor(gems$poa,
                   levels = c(1,2,3,4),
                   labels = c("Bilabial", "Dental", "Retroflex","Velar"))
sings$poa <- factor(sings$poa,
                    levels = c(1,2,3,4),
                    labels = c("Bilabial", "Dental", "Retroflex","Velar"))
gems$voicing<-factor(gems$voicing,
                     levels = c(T,F),
                     labels = c("Voiced", "Voiceless"))
sings$voicing<-factor(sings$voicing,
                      levels = c(T,F),
                      labels = c("Voiced", "Voiceless"))
summary.gems <- data.frame(
  Means = gems$mean,
  Voicing = gems$voicing,
  POA = gems$poa,      
  CI.half = gems$CI.half
)
summary.sings <- data.frame(
  Means = sings$mean,
  Voicing = sings$voicing,
  POA = sings$poa,      
  CI.half = sings$CI.half
)

library(ggplot2)
par(mfrow=c(1,2))
# qplot(data=summary.gems,
#       y=Means,
#       x=Voicing,
#       group=POA,
#       ymin=Means-CI.half,
#       ymax=Means+CI.half,
#       geom=c("point", "errorbar", "line"),
#       color=POA,
# #       shape=POA,
#       width=0.25) + theme_bw()
# qplot(data=summary.sings,
#       y=Means,
#       x=Voicing,
#       group=POA,
#       ymin=Means-CI.half,
#       ymax=Means+CI.half,
#       geom=c("point", "errorbar", "line"),
#       color=POA,
# #       shape=POA,
#       width=0.25) + theme_bw()

a<-ggplot(data=summary.sings, aes(x=Voicing, y=Means, group=POA,color=POA,shape=POA)) +
  geom_line(size=0.8) +
  geom_errorbar(aes(ymin=Means-CI.half,ymax=Means+CI.half,), width=.1)+
  geom_point(size=3.5) +
  scale_colour_hue(l=50) +
#   ylim(60,110)+
  theme_bw() +
  guides(fill=FALSE)+
  theme(panel.background=element_blank(),
        axis.title.x=element_blank(),
        legend.position="none",
        panel.grid.major.x=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank(),
        plot.margin=unit(c(1, 1, 0.5, 0.5), "lines"),
        plot.title=element_text(size=rel(1.2)),
        strip.background=element_rect(fill="grey90", colour="grey50"))+
  coord_fixed(ratio = 0.04)+
  ggtitle("Singletons")

b<-ggplot(data=summary.gems, aes(x=Voicing, y=Means, group=POA,color=POA,shape=POA)) +
  geom_line(size=0.8) +
  geom_errorbar(aes(ymin=Means-CI.half,ymax=Means+CI.half,), width=.1)+
  geom_point(size=3.5) +
  scale_colour_hue(l=50)+
#   ylim(60,110)+
  theme_bw() +
  theme(panel.background=element_blank(),
        axis.title.x=element_blank(),
        panel.grid.major.x=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank(),
        plot.margin=unit(c(1, 1, 0.5, 0.5), "lines"),
        plot.title=element_text(size=rel(1.2)),
        strip.background=element_rect(fill="grey90", colour="grey50"))+
  ggtitle("Geminates")

require(gridExtra)
grid.arrange(a,b, ncol=2, main=textGrob("Interaction effect of POA, voicing and gemination on V2 Duration",gp=gpar(fontsize=15,font=2)))