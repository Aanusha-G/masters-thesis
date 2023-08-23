n=length(primary_data$File)
POA = primary_data$POA
MOA = primary_data$MOA
p="V"
m="VS"
vowel_list=c("a","i","o","O","u")
for (i in vowel_list){
  f0_v1=vector(mode="double",length=0)
  f0_v2=vector(mode="double",length=0)
  for (j in 1:n){
    sing = grepl("_", MOA[j])
    if (V1[j]==i & sing==F){
      f0_v1=append(f0_v1,F0_V1[j],after=length(f0_v1))
    }
    if (V2[j]==i & sing==F){
      f0_v2=append(f0_v2,F0_V2[j],after=length(f0_v2))
    }
  }
f0_v1=as.numeric(f0_v1)
f0_v2=as.numeric(f0_v2)
print(t.test(f0_v1,f0_v2)$p.value)
}