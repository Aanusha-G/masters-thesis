primary_data <- read.delim("C:/Users/La Alquimista/Dropbox/Ghosh_MA_Thesis/Data/analysis_new.txt", stringsAsFactors=F)
View(primary_data)
attach(primary_data)

n= length(primary_data$File)
MOA = primary_data$MOA
POA = primary_data$POA
#POA<-factor(POA)
#Vowel.Type <- factor(Vowel.Type)

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
    gem_cd = append(gem_cd,Burst.Duration[i],after=length(gem_cd))
    gem_vs_cd = append(gem_vs_cd,Burst.Duration[i],after=length(gem_vs_cd))
  }
  else if (sing==F & voiced == F ){
    gem_cd = append(gem_cd,Burst.Duration[i],after=length(gem_cd))
    gem_vls_cd = append(gem_vls_cd,Burst.Duration[i],after=length(gem_vls_cd))
  }
  else if (sing== T & voiced == F ){
    sing_cd = append(sing_cd,Burst.Duration[i],after=length(sing_cd))
    sing_vls_cd = append(sing_vls_cd,Burst.Duration[i],after=length(sing_vls_cd))
  }
  else {
    if (sing == T & voiced == T ){
      sing_cd = append(sing_cd,Burst.Duration[i],after=length(sing_cd))
      sing_vs_cd = append(sing_vs_cd,Burst.Duration[i],after=length(sing_vs_cd))
    }
  }
}

t.test(sing_cd,gem_cd)$p.value
t.test(sing_vls_cd,sing_vs_cd)$p.value
t.test(gem_vls_cd,gem_vs_cd)$p.value

t.test(sing_cd,gem_cd,var.equal=T)$p.value
t.test(sing_vls_cd,sing_vs_cd,var.equal=T)$p.value
t.test(gem_vls_cd,gem_vs_cd,var.equal=T)$p.value