a = c(burst_sing_vls,burst_gem_vls)
b = c("SING","GEM")
b =rep(b,c(length(burst_sing_vls),length(burst_gem_vls)))
boxplot(a~b)

a = c(burst_sing_vd,burst_gem_vd)
b = c("SING","GEM")
b =rep(b,c(length(burst_sing_vd),length(burst_gem_vd)))
boxplot(a~b)