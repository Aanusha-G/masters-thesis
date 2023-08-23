primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)

attach(primary_data)
n= length(primary_data$File)
MOA = primary_data$MOA
POA<-factor(POA)

sing=vector(mode="logical", length=0)
voiced =vector(mode="logical", length=0)
levels=c("BL","D","R","V")
consonant_data=vector(mode="double",length=0)
poa_data=vector(length=0)
for (i in 1:n){
  s= grepl("_", MOA[i])
  v = grepl("VS",MOA[i])
  sing=append(sing,s,after=length(sing))
  voiced=append(voiced,v,after=length(voiced))
  consonant_data=append(consonant_data,Consonant.Duration[i],after=length(consonant_data))
  poa_data=append(poa_data,POA[i],after=length(poa_data))
}

poa_data<-factor(poa_data)
data<-data.frame(consonant_Dur=consonant_data, singleton=sing, poa =poa_data, voicing=voiced)
aov = aov(consonant_Dur~singleton*poa*voicing,data=data)
summary(aov)

gems<-data[which(data$singleton==FALSE),]
sings<-data[which(data$singleton==TRUE),]
gems$mean <- with(gems,ave(consonant_Dur,poa,voicing,FUN=mean))
sings$mean <- with(sings,ave(consonant_Dur,poa,voicing,FUN=mean))
gems.model <- lm(consonant_Dur ~ poa*voicing, data=gems)
sings.model <- lm(consonant_Dur ~ poa*voicing, data=sings)

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

a<-ggplot(data=summary.sings, aes(x=Voicing, y=Means, group=POA,color=POA,shape=POA)) +
  geom_line(size=0.8) +
  geom_errorbar(aes(ymin=Means-CI.half,ymax=Means+CI.half,), width=.1)+
  geom_point(size=3.5) +
  scale_colour_hue(l=50) +
  theme_bw() +
  guides(fill=FALSE)+
  ylim(50,180)+
  theme(panel.background=element_blank(),
        axis.title.x=element_blank(),
        legend.position="none",
        panel.grid.major.x=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank(),
        plot.title=element_text(size=rel(1.2)),
        strip.background=element_rect(fill="grey90", colour="grey50"))+
        ggtitle("Singletons")

b<-ggplot(data=summary.gems, aes(x=Voicing, y=Means, group=POA,color=POA,shape=POA)) +
  geom_line(size=0.8) +
  geom_errorbar(aes(ymin=Means-CI.half,ymax=Means+CI.half,), width=.1)+
  geom_point(size=3.5) +
  scale_colour_hue(l=50)+
  theme_bw() +
  ylim(50,180)+
  theme(panel.background=element_blank(),
        axis.title.x=element_blank(),
        panel.grid.major.x=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank(),
        plot.title=element_text(size=rel(1.2)),
        strip.background=element_rect(fill="grey90", colour="grey50"))+
        theme(legend.text=element_text(size=8))+
        ggtitle("Geminates")

grid.arrange(a,b, ncol=2, widths = unit(c(0.9,1.65),"null"))

require(gridExtra)
grid.arrange(a,b, ncol=2, main=textGrob("Interaction effect of POA, voicing and gemination on consonant duration",gp=gpar(fontsize=13,font=2)),widths = unit(c(1.2,1.7),"null"))


gA <- ggplot_gtable(ggplot_build(a))
gB <- ggplot_gtable(ggplot_build(b))
maxWidth = grid::unit.pmax(gA$widths[2:3], gB$widths[2.2:3])
gA$widths[2:3] <- as.list(maxWidth)
gB$widths[2.2:3] <- as.list(maxWidth)
grid.arrange(gA, gB, ncol=2)
