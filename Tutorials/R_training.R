library(devtools)
install_github("mrflick/ocsls")
library(tidyverse)
library(ocsls)
View(dates)
tdates <- dates %>% filter(is.traditional.age)
tdates %>% ggplot()+geom_boxplot(aes(grade,dates.since.started.college))
lm(physattr~grade,tdates) %>% summary()
tdates %>% ggplot()+geom_histogram(aes(physattr,fill=bio.sex))
tdates %>% drop_na(bio.sex) %>% ggplot()+geom_bar(aes(physattr,y=..prop..,fill=bio.sex),position="dodge")
ggplot(tdates)+geom_histogram(aes(height.in.inches/12),bins=15)

x <- 1:10
sqrt(x)
map(x,sqrt)
draws <- map(2:20,function(x) rnorm(25,mean=0,sd=x))
draws <- map(2:20, ~rnorm(25,mean=0,sd=.x))
map(draws,sd)
map_dbl(draws,sd)
N<-20
N <- numeric(30)
for(i in 2:30){
   f <- rpois(1,.15*N[i-1])
   d <- rbinom(1,N[i-1],.1)
   N[i] <- N[i-1]+f-d
}
