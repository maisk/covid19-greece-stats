##########################################################################################
# LOAD
##########################################################################################
#library(plotly)
library(plyr)
#library(lubridate)
#library(drc)
rm(list=ls(all=TRUE))
graphics.off()
cat("\014")
#environment_options()
confirmed<-read.csv("./data/covid/time_series_covid19_confirmed_global.csv",stringsAsFactors=FALSE,check.names=FALSE)
deaths<-read.csv("./data/covid/time_series_covid19_deaths_global.csv",stringsAsFactors=FALSE,check.names=FALSE)
recovered<-read.csv("./data/covid/time_series_covid19_recovered_global.csv",stringsAsFactors=FALSE,check.names=FALSE)
country_code<-read.csv("./data/countrycode.csv",stringsAsFactors=FALSE,check.names=FALSE)
confirmed$Lat<-confirmed$Long<-deaths$Lat<-deaths$Long<-recovered$Lat<-recovered$Long<-NULL
##########################################################################################
#
##########################################################################################
covid_c<-reshape2::melt(confirmed,id.vars=c("Province/State","Country/Region"),variable.name="date",value.name="confirmed")
covid_d<-reshape2::melt(deaths,id.vars=c("Province/State","Country/Region"),variable.name="date",value.name="deaths")
covid_r<-reshape2::melt(recovered,id.vars=c("Province/State","Country/Region"),variable.name="date",value.name="recovered")
covid_all<-Reduce(function(x,y) merge(x,y,all=TRUE,), list(covid_c, covid_d, covid_r))
names(covid_all)<-tolower(make.names(names(covid_all)))
covid_all$date<-as.Date(as.character(covid_all$date),"%m/%d/%y")
covid_all_country<-plyr::ddply(covid_all,.(country.region,date),plyr::numcolwise(sum,na.rm=TRUE))
covid_all_country<-merge(country_code,covid_all_country,by.x="country",by.y="country.region",all=TRUE)





save(covid_c,covid_d,covid_r,confirmed,deaths,recovered,covid_all_country,covid_all,country_code,file='covid_data.Rdata')
