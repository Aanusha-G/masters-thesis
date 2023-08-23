primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis.txt", stringsAsFactors=F)
View(primary_data)
attach(primary_data)
n= length(primary_data$File)
MOA = primary_data$MOA
POA = primary_data$POA
#POA<-factor(POA)
#Vowel.Type <- factor(Vowel.Type)
sing_vd =vector(mode="double", length=0)
sing_vls =vector(mode="double", length=0)
gem_vd =vector(mode="double", length=0)
gem_vls =vector(mode="double", length=0)
POA_list=c("BL","D","R","V")
for (j in POA_list){
  for (i in 1:n){
    sing = grepl("_", MOA[i])
    voiced = grepl("VS",MOA[i])
    if (sing==F & voiced == T & POA[i]==j){
      gem_vd = append(gem_vd,V2.Dur[i],after=length(gem_vd))
    }
    else if (sing==F & voiced == F & POA[i]==j){
      gem_vls = append(gem_vls,V2.Dur[i],after=length(gem_vls))
    }
    else if (sing==T & voiced == F & POA[i]==j){
      sing_vls = append(sing_vls,V2.Dur[i],after=length(sing_vls))
    }
    else {
      if (sing==T & voiced == T & POA[i]==j){
        sing_vd =  append(sing_vd,V2.Dur[i],after=length(sing_vd))
      }
    }
  }
  cat(j,"\n")
  cat("V_Sing vs V_Gem",t.test(sing_vd,gem_vd)$p.value,"\n")
  cat("VLS_Sing vs VLS_Gem",t.test(sing_vls,gem_vls)$p.value,"\n")
  cat("VLS_Sing vs V_Sing",t.test(sing_vls,sing_vd)$p.value,"\n")
  cat("V_Gem vs VLS_Gem",t.test(gem_vls,gem_vd)$p.value,"\n \n")
}