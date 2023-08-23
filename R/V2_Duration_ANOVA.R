primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)
# View(primary_data)
attach(primary_data)
n= length(primary_data$File)
MOA = primary_data$MOA
POA = primary_data$POA

sing=vector(mode="logical", length=0)
voiced =vector(mode="logical", length=0)
for (i in 1:n){
  s= grepl("_", MOA[i])
  v = grepl("VS",MOA[i])
  sing=append(sing,s,after=length(sing))
  voiced=append(voiced,v,after=length(voiced))
}
singleton<-factor(sing)
poa<-factor(POA)
voicing<-factor(voiced)
data<-data.frame(V2.Dur, singleton,poa, voicing)
fit = aov(V2.Dur~singleton*poa*voicing,data=data)
summary(fit)
TukeyHSD(fit)
fit = aov(V2.Dur~singleton+poa*voicing,data=data)
summary(fit)
