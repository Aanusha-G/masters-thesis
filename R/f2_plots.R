primary_data <- read.delim("/Users/aanusha/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)
View(primary_data)
attach(primary_data)
n= length(primary_data$File)
MOA = primary_data$MOA
POA = primary_data$POA

f2_d_gem_onset=vector(mode="double",length=0)
f2_d_sing_onset=vector(mode="double",length=0)
f2_d_gem_mid=vector(mode="double",length=0)
f2_d_sing_mid=vector(mode="double",length=0)
vowel_list=c("a","i","e","o","O","u")
for (i in 1:n){
  speaker=strsplit(File[i],"_")[[1]]
  if (speaker=="chan" && V1[i] == "i" && V2[i]=="i" && MOA[i]=="VLS_N" && POA[i] == "D" ){
    f2_d_sing_onset=append(f2_d_sing_onset,F2_onset_V2[i],after=length(f2_d_sing_onset))
    f2_d_sing_mid=append(f2_d_sing_mid,F2_mid_V2[i],after=length(f2_d_sing_mid))
  }
  if (speaker=="chan" && V1[i] == "i" && V2[i]=="i" && MOA[i]=="VLS" && POA[i] == "D" ){
    f2_d_gem_onset=append(f2_d_gem_onset,F2_onset_V2[i],after=length(f2_d_gem_onset))
    f2_d_gem_mid=append(f2_d_gem_mid,F2_mid_V2[i],after=length(f2_d_gem_mid))
  }
}
plot(f2_d_gem_mid,f2_d_gem_onset)
res=lm(f2_d_gem_onset~f2_d_gem_mid)
abline(res)

fit1 <- lm(f2_d_gem_onset~f2_d_gem_mid)
summary(fit1)

plot(f2_d_sing_mid,f2_d_sing_onset)
res=lm(f2_d_sing_onset~f2_d_sing_mid)
abline(res)

fit2 <- lm(f2_d_sing_onset~f2_d_sing_mid)
summary(fit2)
summar(res)

mean(f2_d_sing_mid)
mean(f2_d_gem_mid)

mean(f2_d_sing_onset)
mean(f2_d_gem_onset)

x=c(1:length(f2_d_sing_onset))
plot(x,f2_d_sing_onset)
lines(x,f2_d_sing_onset)
x=c(1:length(f2_d_gem_onset))
plot(x,f2_d_gem_onset)

