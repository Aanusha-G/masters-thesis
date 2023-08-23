primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)
View(primary_data)
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
data<-data.frame(Burst_Amp=Burst.RMS, singleton=sing, voicing = voiced)
aov = aov(Burst_Amp~singleton*voicing,data=data)
summary(aov)
