install.packages("nycflights13")
library(nycflight13)
library(dplyr)
library(tidyr)
library(ocsls)
View(flights)
flights <- tbl_df(flights)
filter(flights,dest=='ATL' & month==6)
.5 %>% sin() %>% exp() %>% round(2)
-100 %>% runif(10,.)
flights %>% group_by(carrier) %>% 
  summarise(avgdelay=mean(dep_delay,na.rm=TRUE),sddelay=sd(dep_delay,na.rm=TRUE)) %>%
  arrange(desc(avgdelay))
flights %>% count(carrier)
summary(flights)
flights %>% filter(dest=='DTW')%>%group_by(month) %>%summarise(count=n())%>% arrange(desc(count)) 

dates = tbl_df(dates)
#Which school has the most responses?
dates %>% group_by(school) %>% summarise(numsurvey=n()) %>% arrange(desc(numsurvey))
# U Mass has the most number of surveys of 3607.
#How many schools had surveys in 2009?
dates %>% filter(survey.imputed.year==2009) %>% summarise(count=n_distinct(school))
#12.
#How many respondents reported being in a sorority or fraternity (use "greek")?
dates %>% filter(greek==1) %>% count()
#2857.
#What's the ratio of female to male respondents (use "bio.sex")
dates %>% summarise(quotient=count(filter(dates,bio.sex=='MALE'))/count(filter(dates,bio.sex=='FEMALE')))
# Above code doesn't work. Yet I can still get the ratio to be 2.24