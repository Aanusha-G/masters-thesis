primary_data <- read.delim("/Users/aanusha/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)
# View(primary_data)
attach(primary_data)
library(ggplot2)
library(grid)
library(gridExtra)
n= length(primary_data$File)
MOA = primary_data$MOA
POA = primary_data$POA


f2_d_gem_onset=vector(mode="double",length=0)
f2_d_sing_onset=vector(mode="double",length=0)
f2_d_gem_mid=vector(mode="double",length=0)
f2_d_sing_mid=vector(mode="double",length=0)
for (i in 1:n){
  speaker=strsplit(File[i],"_")[[1]]
  if (speaker=="chan" && V1[i] == "i" && MOA[i]=="VLS_N" && POA[i] == "D" ){
    f2_d_sing_onset=append(f2_d_sing_onset,F2_onset_V2[i],after=length(f2_d_sing_onset))
    f2_d_sing_mid=append(f2_d_sing_mid,F2_mid_V2[i],after=length(f2_d_sing_mid))
  }
  if (speaker=="chan" && V1[i] == "i" && MOA[i]=="VLS" && POA[i] == "D" ){
    f2_d_gem_onset=append(f2_d_gem_onset,F2_onset_V2[i],after=length(f2_d_gem_onset))
    f2_d_gem_mid=append(f2_d_gem_mid,F2_mid_V2[i],after=length(f2_d_gem_mid))
  }
}

fit1 <- lm(f2_onset ~ f2_mid, data = plot_data)
summary(fit1)

x<-c(rep("G",length(f2_d_gem_onset)),rep("S",length(f2_d_sing_onset)))
f2_mid<-c(f2_d_gem_mid,f2_d_sing_mid)
f2_onset<-c(f2_d_gem_onset,f2_d_sing_onset)
plot_data<-data.frame(f2_mid,f2_onset,x)
ggplot(data=plot_data, aes(x=f2_mid, y=f2_onset, group=x,color=x)) +
geom_point(shape=1, size=3.5) + 
scale_colour_hue(l=50,
                 name="Lines",
                 breaks=c("G", "S"),
                 labels=c("Geminate", "Singleton")) +
stat_smooth(method="lm",formula=y~x,fullrange=TRUE, se=FALSE,size=1,alpha = 0.1)+
xlab("F2 at V (Hz)") +
ylab("F2 at C (Hz)")+
theme_bw() +
theme(panel.background=element_blank(),
      axis.title.x=element_blank(),
      panel.grid.minor=element_blank(),
      plot.background=element_blank(),
      plot.margin=unit(c(1, 1, 0.5, 0.5), "lines"),
      plot.title=element_text(size=rel(1.2)),
      strip.background=element_rect(fill="grey90", colour="grey50"))+
scale_shape_discrete(name="Lines",
                     breaks=c("G", "S"),
                     labels=c("Geminate", "Singleton"))

fit<-lm(f2_onset~f2_mid,data=plot_data)
summary(fit)
r2 = summary(fit)$adj.r.squared

