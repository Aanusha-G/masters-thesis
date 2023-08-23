primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)
attach(primary_data)
n= length(primary_data$File)
MOA = primary_data$MOA
POA = primary_data$POA

burst_sing_vd =vector(mode="double", length=0)
burst_sing_vls =vector(mode="double", length=0)
burst_gem_vd =vector(mode="double", length=0)
burst_gem_vls =vector(mode="double", length=0)
for (i in 1:n){
  sing = grepl("_", MOA[i])
  voiced = grepl("VS",MOA[i])
  if (sing==F & voiced == T ){
    burst_gem_vd = append(burst_gem_vd,Burst.RMS[i],after=length(burst_gem_vd))
  }
  else if (sing==F & voiced == F ){
    burst_gem_vls = append(burst_gem_vls,Burst.RMS[i],after=length(burst_gem_vls))
  }
  else if (sing==T & voiced == F ){
    burst_sing_vls = append(burst_sing_vls,Burst.RMS[i],after=length(burst_sing_vls))
  }
  else {
    if (sing==T & voiced == T ){
      burst_sing_vd =  append(burst_sing_vd,Burst.RMS[i],after=length(burst_sing_vd))
    }
  }
}

library(ggplot2)
sing_gem_broken_down<-data.frame(x=c("Voiceless Singletons","Voiced Singletons","Voiceless Geminates","Voiced Geminates"),
                                 y=c(mean(burst_sing_vls),mean(burst_sing_vd),mean(burst_gem_vls),mean(burst_gem_vd)))
ggplot(data=sing_gem_broken_down, aes(x=x, y=y, fill=x)) +  
  geom_bar(stat="identity",width=0.75) +
  scale_fill_manual(values=c("black", "gray25","gray50","gray69")) + 
  xlab("") + 
  ylab("Average Burst Amplitude") +
  scale_x_discrete(labels=c("Voiced Geminates" = "Voiced\nGeminates", "Voiced Singletons" = "Voiced\nSingletons",
                            "Voiceless Geminates" = "Voiceless\nGeminates", "Voiceless Singletons" = "Voiceless\nSingletons")) +
  ggtitle("Variation of Burst Amplitude") +
  theme(plot.title = element_text(lineheight=.8, face="bold"))
    