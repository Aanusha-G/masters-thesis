primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)
attach(primary_data)
library(ggplot2)
n= length(primary_data$File)
MOA = primary_data$MOA
POA = primary_data$POA
F0_V1<-as.numeric(F0_V1)
#POA<-factor(POA)
#Vowel.Type <- factor(Vowel.Type)

sing_f0 =vector(mode="double", length=0)
gem_f0 =vector(mode="double", length=0)

sing_vls_f0=vector(mode="double", length=0)
gem_vls_f0 =vector(mode="double", length=0)
sing_vs_f0 =vector(mode="double", length=0)
gem_vs_f0 =vector(mode="double", length=0)

for (i in 1:n){
  sing = grepl("_", MOA[i])
  voiced = grepl("VS",MOA[i])
  if (sing==F & voiced == T ){
    gem_f0 = append(gem_f0,F0_V1[i],after=length(gem_f0))
    gem_vs_f0 = append(gem_vs_f0,F0_V1[i],after=length(gem_vs_f0))
  }
  else if (sing==F & voiced == F ){
    gem_f0 = append(gem_f0,F0_V1[i],after=length(gem_f0))
    gem_vls_f0 = append(gem_vls_f0,F0_V1[i],after=length(gem_vls_f0))
  }
  else if (sing== T & voiced == F ){
    sing_f0 = append(sing_f0,F0_V1[i],after=length(sing_f0))
    sing_vls_f0 = append(sing_vls_f0,F0_V1[i],after=length(sing_vls_f0))
  }
  else {
    if (sing == T & voiced == T ){
      sing_f0 = append(sing_f0,F0_V1[i],after=length(sing_f0))
      sing_vs_f0 = append(sing_vs_f0,F0_V1[i],after=length(sing_vs_f0))
    }
  }
}

gem_vls_f0<- gem_vls_f0[!is.na(gem_vls_f0)]

sing_gem_broken_down<-data.frame(x=c("Voiceless Singletons","Voiced Singletons","Voiceless Geminates","Voiced Geminates"),
                                 y=c(mean(sing_vls_f0),mean(sing_vs_f0),mean(gem_vls_f0),mean(gem_vs_f0)))
ggplot(data=sing_gem_broken_down, aes(x=x, y=y, fill=x)) +  
  geom_bar(stat="identity",width=0.75) +
  scale_fill_manual(values=c("black", "gray25","gray50","gray69")) + 
  xlab("") + 
  ylab("Duration in milliseconds") +
  scale_x_discrete(labels=c("Voiced Geminates" = "Voiced\nGeminates", "Voiced Singletons" = "Voiced\nSingletons",
                            "Voiceless Geminates" = "Voiceless\nGeminates", "Voiceless Singletons" = "Voiceless\nSingletons")) +
  ggtitle("Variation of F0 for V1") +
  theme(plot.title = element_text(lineheight=.8, face="bold"))
