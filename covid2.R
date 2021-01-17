#library(plotly)
#library(plyr)
#library(lubridate)
#library(drc)
######################################################################
rm(list=ls(all=TRUE))
graphics.off()
cat("\014")
######################################################################

load("covid_data.Rdata");


width1=1100
height1=600
countries <-c('greece','sweden','italy','serbia','croatia','bosnia','bulgaria','belgium','albania','romania');
#cidx <- function(cname){
#  match(cname,countries);
#}

#'greece','sweden','italy','serbia','croatia','bosnia','bulgaria','belgium'
population <- list();
population['sweden']<-10099265  #worldometers2020
population['italy']<-60461826   #worldometers2020 
population['greece']<-10423054  #worldometers2020
population['serbia']<-8737371   #worldometers2020
population['croatia']<-4105267  #worldometers2020
population['bosnia']<-3280819   #worldometers2020
population['bulgaria']<-6948445 #worldometers2020
population['belgium']<-11589623  #worldometers2020
population['albania']<-2877797  #worldometers2020
population['romania']<-19237691  #worldometers2020


#'greece','sweden','italy','serbia','croatia','bosnia','bulgaria'
covid = list(
covid_all[covid_all$country.region%in%"Greece",],
covid_all[covid_all$country.region%in%"Sweden",],
covid_all[covid_all$country.region%in%"Italy",],
covid_all[covid_all$country.region%in%"Serbia",],
covid_all[covid_all$country.region%in%"Croatia",],
covid_all[covid_all$country.region%in%"Bosnia and Herzegovina",],
covid_all[covid_all$country.region%in%"Bulgaria",],
covid_all[covid_all$country.region%in%"Belgium",],
covid_all[covid_all$country.region%in%"Albania",],
covid_all[covid_all$country.region%in%"Romania",]
);
names(covid)<- countries;
#summary(covid)


#covid[['greece']]$confirmed
#covid$greece$confirmed

perc<-100
for (i in countries){
  covid[[i]]$confirmed_r  <-  (covid[[i]]$confirmed /population[[i]])*perc
}
for (i in countries){
  covid[[i]]$deaths_r  <-  (covid[[i]]$deaths /population[[i]])*perc
}
for (i in countries){
  covid[[i]]$fatality_r  <-  (covid[[i]]$deaths / covid[[i]]$confirmed)*perc
}
#head(covid[['greece']])


plot1 <- function(var_name, fname,title, country,color,max_default=0){
  cat('plot1:',var_name,',',fname,',',title,"\n")
  maxv <- 0;
  if (max_default == 0){
    for (i in country){
      #cat(':',covid[[i]][[var_name]],"\n");
      maxv <- max(maxv, max(covid[[i]][[var_name]],na.rm=TRUE))
    }
  } else {
    maxv <- max_default
  }
  cat("max:",maxv,"\n")
  clen = length(country);
  fname_f <- paste('target','/',fname, sep='' )
  png(file=fname_f,width=width1,height=height1)

  c <-0;
  for (i in country){
    c <- c +1;
    if (c == 1){
      plot(covid[[i]]$date, covid[[i]][[var_name]],col=color[c],
           lwd=1.3, cex=1.6, cex.lab=1.6, cex.main=1.6, cex.sub=1.6, cex.axis=1.6, main=title,xlab='time',ylab=title, type="l", ylim=c(0,maxv))
    } else {
      lines(lwd=1.3, covid[[i]]$date, covid[[i]][[var_name]],col=color[c])    
    }
  }
  legend(x="topleft",
         legend=country,   
         col=color,
         lty=1,
         pch=NA ,
         cex=1.8)
  grid()
  dev.off()
}




plot_countries1<-c('greece','sweden','italy','belgium')
plot_colors1<-c('black','blue','red','green')

plot_countries2<-c('greece','croatia','serbia')
plot_colors2<-c('black','blue','red')

plot_countries3<-c('greece','bulgaria','bosnia')
plot_colors3<-c('black','green','orange')

plot_countries4<-c('greece','romania','albania')
plot_colors4<-c('black','green','orange')

#################################################
## DEATHS RATE
#################################################
title<-'deaths %'
plot_var<-'deaths_r';

plot_fname<-'covid_deaths_gsi.png'
plot1(plot_var,plot_fname,title,plot_countries1,plot_colors1);
plot_fname<-'covid_deaths_gcs.png'
plot1(plot_var,plot_fname,title,plot_countries2,plot_colors2);
plot_fname<-'covid_deaths_gbb.png'
plot1(plot_var,plot_fname,title,plot_countries3,plot_colors3);
plot_fname<-'covid_deaths_gar.png'
plot1(plot_var,plot_fname,title,plot_countries4,plot_colors4);
#################################################


#################################################
## FATALITY RATE
#################################################
title<-'fatality %'
plot_var<-'fatality_r';
plot_fname<-'covid_fatality_gsi.png'
plot1(plot_var,plot_fname,title,plot_countries1,plot_colors1);
plot_fname<-'covid_fatality_gcs.png'
plot1(plot_var,plot_fname,title,plot_countries2,plot_colors2);
plot_fname<-'covid_fatality_gbb.png'
plot1(plot_var,plot_fname,title,plot_countries3,plot_colors3,6.7);
plot_fname<-'covid_fatality_gar.png'
plot1(plot_var,plot_fname,title,plot_countries4,plot_colors4);
#################################################


#################################################
## CONFIRMED RATE
#################################################
title<-'confirmed %'
plot_var<-'confirmed_r';
plot_fname<-'covid_confirmed_gsi.png'
plot1(plot_var,plot_fname,title,plot_countries1,plot_colors1);
plot_fname<-'covid_confirmed_gcs.png'
plot1(plot_var,plot_fname,title,plot_countries2,plot_colors2);
plot_fname<-'covid_confirmed_gbb.png'
plot1(plot_var,plot_fname,title,plot_countries3,plot_colors3);
plot_fname<-'covid_confirmed_gar.png'
plot1(plot_var,plot_fname,title,plot_countries4,plot_colors4);
#################################################3
