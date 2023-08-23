primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)
attach(primary_data)
n= length(primary_data$File)
MOA = primary_data$MOA
POA = primary_data$POA

sing_vd =vector(mode="double", length=0)
sing_vls =vector(mode="double", length=0)
gem_vd =vector(mode="double", length=0)
gem_vls =vector(mode="double", length=0)

for (i in 1:n){
  sing = grepl("_", MOA[i])
  voiced = grepl("VS",MOA[i])
  if (sing==F & voiced == T ){
    gem_vd = append(gem_vd,V2.Dur[i],after=length(gem_vd))
  }
  else if (sing==F & voiced == F){
    gem_vls = append(gem_vls,V2.Dur[i],after=length(gem_vls))
  }
  else if (sing==T & voiced == F){
    sing_vls = append(sing_vls,V2.Dur[i],after=length(sing_vls))
  }
  else {
    if (sing==T & voiced == T){
      sing_vd =  append(sing_vd,V2.Dur[i],after=length(sing_vd))
    }
  }
}
sing_gem_broken_down<-data.frame(x=c("Voiceless Singletons","Voiced Singletons","Voiceless Geminates","Voiced Geminates"),y=c(mean(sing_vls),mean(sing_vd),mean(gem_vls),mean(gem_vd)))
ggplot(data=sing_gem_broken_down, aes(x=x, y=y, fill=x)) +  
  geom_bar(stat="identity",width=0.75) +
  scale_fill_manual(values=c("black", "gray25","gray50","gray69")) + 
  xlab("") + 
  ylab("Duration in milliseconds") +
  scale_x_discrete(labels=c("Voiced Geminates" = "Voiced\nGeminates", "Voiced Singletons" = "Voiced\nSingletons",
                            "Voiceless Geminates" = "Voiceless\nGeminates", "Voiceless Singletons" = "Voiceless\nSingletons")) +
  ggtitle("Variation of V2 Duration") +
  theme(plot.title = element_text(lineheight=.8, face="bold"))

