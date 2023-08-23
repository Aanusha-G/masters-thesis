primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis.txt", stringsAsFactors=F)

attach(primary_data)
library(ggplot2)
n= length(primary_data$File)
MOA = primary_data$MOA
POA = primary_data$POA

sing_cd =vector(mode="double", length=0)
gem_cd =vector(mode="double", length=0)

sing_vls_cd=vector(mode="double", length=0)
gem_vls_cd =vector(mode="double", length=0)
sing_vs_cd =vector(mode="double", length=0)
gem_vs_cd =vector(mode="double", length=0)

for (i in 1:n){
  sing = grepl("_", MOA[i])
  voiced = grepl("VS",MOA[i])
  if (sing==F & voiced == T ){
    gem_cd = append(gem_cd,Consonant.Duration[i],after=length(gem_cd))
    gem_vs_cd = append(gem_vs_cd,Consonant.Duration[i],after=length(gem_vs_cd))
  }
  else if (sing==F & voiced == F ){
    gem_cd = append(gem_cd,Consonant.Duration[i],after=length(gem_cd))
    gem_vls_cd = append(gem_vls_cd,Consonant.Duration[i],after=length(gem_vls_cd))
  }
  else if (sing== T & voiced == F ){
    sing_cd = append(sing_cd,Consonant.Duration[i],after=length(sing_cd))
    sing_vls_cd = append(sing_vls_cd,Consonant.Duration[i],after=length(sing_vls_cd))
  }
  else {
    if (sing == T & voiced == T ){
      sing_cd = append(sing_cd,Consonant.Duration[i],after=length(sing_cd))
      sing_vs_cd = append(sing_vs_cd,Consonant.Duration[i],after=length(sing_vs_cd))
    }
  }
}

t.test(sing_cd,gem_cd)$p.value
t.test(sing_vls_cd,sing_vs_cd)$p.value
t.test(gem_vls_cd,gem_vs_cd)$p.value

t.test(sing_cd,gem_cd,var.equal=T)$p.value
t.test(sing_vls_cd,sing_vs_cd,var.equal=T)$p.value
t.test(gem_vls_cd,gem_vs_cd,var.equal=T)$p.value

sing <-data.frame(x=c("Voiceless Singletons","Voiced Singletons"),y=c(mean(sing_vls_cd),mean(sing_vs_cd)))
gem <-data.frame(x=c("Voiceless Geminates","Voiced Geminates"),y=c(mean(gem_vls_cd),mean(gem_vs_cd)))
sing_gem <-data.frame(x=c("Singletons","Geminates"),y=c(mean(sing_cd),mean(gem_cd)))

# ggplot(data=sing, aes(x=x, y=y, fill=x)) +  geom_bar(stat="identity")
# ggplot(data=gem, aes(x=x, y=y, fill=x)) +  geom_bar(stat="identity")
# ggplot(data=sing_gem, aes(x=x, y=y, fill=x)) +  geom_bar(stat="identity")


# ggplot(data=sing_gem_broken_down, aes(x=x, y=y, fill=x)) +  geom_bar(stat="identity",width=0.75) + scale_fill_manual(values=c("deepskyblue4", "darkgreen", "deepskyblue3","forestgreen")) + xlab("") + ylab("Duration in milliseconds")+theme(axis.text.x=element_blank())
# ggplot(data=sing_gem_broken_down, aes(x=x, y=y, fill=x)) +  geom_bar(stat="identity",width=0.75) + scale_fill_manual(values=gray.colors(4, start = 0, end = 0.9, gamma = 2, alpha = NULL)) + xlab("") + ylab("Duration in milliseconds")+theme(axis.text.x=element_blank())
# ggplot(data=sing_gem_broken_down, aes(x=x, y=y, fill=x)) +  geom_bar(stat="identity") + scale_fill_manual(values=rep(c("deepskyblue3", "forestgreen"),2))

sing_gem_broken_down<-data.frame(x=c("Voiceless Singletons","Voiced Singletons","Voiceless Geminates","Voiced Geminates"),y=c(mean(sing_vls_cd),mean(sing_vs_cd),mean(gem_vls_cd),mean(gem_vs_cd)))
ggplot(data=sing_gem_broken_down, aes(x=x, y=y, fill=x)) +  
  geom_bar(stat="identity",width=0.75) +
  scale_fill_manual(values=c("black", "gray25","gray50","gray69")) + 
  xlab("") + 
  ylab("Duration in milliseconds") +
  scale_x_discrete(labels=c("Voiced Geminates" = "Voiced\nGeminates", "Voiced Singletons" = "Voiced\nSingletons",
                            "Voiceless Geminates" = "Voiceless\nGeminates", "Voiceless Singletons" = "Voiceless\nSingletons")) +
  ggtitle("Variation of Consonant Duration") +
  theme(plot.title = element_text(lineheight=.8, face="bold"))