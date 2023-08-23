primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)
View(primary_data)
attach(primary_data)
n= length(primary_data$File)
MOA = primary_data$MOA
POA = primary_data$POA
#POA<-factor(POA)
#Vowel.Type <- factor(Vowel.Type)
burst_sing_vd =vector(mode="double", length=0)
burst_sing_vls =vector(mode="double", length=0)
burst_gem_vd =vector(mode="double", length=0)
burst_gem_vls =vector(mode="double", length=0)
POA_list=c("BL","D","R","V")
for (j in POA_list){
  for (i in 1:n){
    sing = grepl("_", MOA[i])
    voiced = grepl("VS",MOA[i])
    if (sing==F & voiced == T & POA[i]==j){
      burst_gem_vd = append(burst_gem_vd,Burst.RMS[i],after=length(burst_gem_vd))
    }
    else if (sing==F & voiced == F & POA[i]==j){
      burst_gem_vls = append(burst_gem_vls,Burst.RMS[i],after=length(burst_gem_vls))
    }
    else if (sing==T & voiced == F & POA[i]==j){
      burst_sing_vls = append(burst_sing_vls,Burst.RMS[i],after=length(burst_sing_vls))
    }
    else {
      if (sing==T & voiced == T & POA[i]==j){
      burst_sing_vd =  append(burst_sing_vd,Burst.RMS[i],after=length(burst_sing_vd))
    }
    }
  }
print (j)
print("Welch t-test")
print(t.test(burst_sing_vd,burst_gem_vd)$p.value)
print(t.test(burst_sing_vls,burst_gem_vls)$p.value)
print(t.test(burst_sing_vls,burst_sing_vd)$p.value)
print(t.test(burst_gem_vls,burst_gem_vd)$p.value)
print("Classic t-test")
print(t.test(burst_sing_vd,burst_gem_vd,var.equal=T)$p.value)
print(t.test(burst_sing_vls,burst_gem_vls,var.equal=T)$p.value)
print(t.test(burst_sing_vls,burst_sing_vd,var.equal=T)$p.value)
print(t.test(burst_gem_vls,burst_gem_vd,var.equal=T)$p.value)
}