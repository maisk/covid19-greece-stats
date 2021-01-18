library(zoo)
#library(numbers)
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


#WINDOW SIZE:
WINDOWS_SIZE=7

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

fn_roll1 <- function(w){
  len<-length(w);
  r <- rep(NA, len-1)
  for (i in seq(len,2,by=-1)){
    j = i-1;
    r[j]<- w[i]-w[j];
  }
  #return (sum(r)/(len-1))
  return (sum(r))
}

fn_roll2 <- function(w){
  #cat(w,"\n")
  len <- length(w)
  r<- w[len]
  return (r)
}

wsize <- WINDOWS_SIZE+1
covid_w <- list();
for (i in countries){
  covid_w[[i]]$deaths  <-  rollapply(covid[[i]]$deaths,wsize,fn_roll1)
  covid_w[[i]]$fatality  <-  rollapply(covid[[i]]$fatality,wsize,fn_roll1)
  covid_w[[i]]$confirmed  <-  rollapply(covid[[i]]$confirmed,wsize,fn_roll1)
  covid_w[[i]]$deaths_r  <-  rollapply(covid[[i]]$deaths_r,wsize,fn_roll1)
  covid_w[[i]]$fatality_r  <-  rollapply(covid[[i]]$fatality_r,wsize,fn_roll1)
  covid_w[[i]]$confirmed_r  <-  rollapply(covid[[i]]$confirmed_r,wsize,fn_roll1)
  
  covid_w[[i]]$date  <- rollapply(covid[[i]]$date,wsize,fn_roll2)
}

covid_greece<-list();
covid_greece$date       <- covid[['greece']]$date
covid_greece$deaths     <- covid[['greece']]$deaths 
covid_greece$fatality_r   <- covid[['greece']]$fatality_r
covid_greece$confirmed  <- covid[['greece']]$confirmed
#covid_greece_w<-list();
covid_greece$w_deaths     <-   rollapply(covid[['greece']]$deaths,2,fn_roll1)
covid_greece$w_confirmed  <-    rollapply(covid[['greece']]$confirmed,2,fn_roll1)
covid_greece$w_date  <-    rollapply(covid[['greece']]$date,2,fn_roll2)

#names(covid_w)
#names(covid_w[['greece']])
#length(covid_w[['greece']]$date)
#length(covid_w[['greece']]$deaths)
#length(covid[['greece']]$date)
#length(covid[['greece']]$deaths)



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
  #cat("max:",maxv,"\n")
  #clen = length(country);
  fname_f <- paste('target','/',fname,'.png', sep='' )
  png(file=fname_f,width=width1,height=height1)

  main_title <- paste(title,'απο την αρχή της πανδημίας' )
  c <-0;
  for (i in country){
    c <- c +1;
    dates<-covid[[i]]$date
    #for (dd in dates){
    #  cat(dd)
    #}
    if (c == 1){
      plot(dates, covid[[i]][[var_name]],col=color[c],
           lwd=1.3, cex=1.6, cex.lab=1.6, cex.main=1.6, cex.sub=1.6, cex.axis=1.6, main=main_title,xlab='time',ylab=title, type="l", ylim=c(0,maxv))
    } else {
      lines(lwd=1.3, dates, covid[[i]][[var_name]],col=color[c])    
    }
  }
  legend(x="topleft",
         legend=country,   
         col=color,
         lty=1,
         pch=NA ,
         lwd=3,
         cex=1.8)
  grid()
  dev.off()
  
  
  
   maxv <- 0;
   for (i in country){
       #cat(':',covid_w[[i]][[var_name]],"\n");
       maxv <- max(maxv, max(covid_w[[i]][[var_name]],na.rm=TRUE))
   }
  
  fname_f <- paste('target','/',fname,'_w.png', sep='' )
  png(file=fname_f,width=width1,height=height1)
  title = paste(title,' Ανα βδομάδα')
  c <-0;
  for (i in country){
    c <- c +1;
    dates <- base::as.Date(zoo::as.Date(covid_w[[i]]$date))
    #dates <- covid_w[[i]]$date
    if (c == 1){
      plot(dates, covid_w[[i]][[var_name]],col=color[c],
           lwd=1.3, cex=1.6, cex.lab=1.6, cex.main=1.6, cex.sub=1.6, cex.axis=1.6, main=title,xlab='time',ylab=title, type="l", ylim=c(0,maxv))
    } else {
      lines(lwd=1.3, dates, covid_w[[i]][[var_name]],col=color[c])    
    }
  }
  legend(x="topleft",
         legend=country,   
         col=color,
         lty=1,
         pch=NA ,
         lwd=3,
         cex=1.8)
  grid()
  dev.off()
}




plot_countries0<-c('greece')
plot_colors0<-c('black')


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

#plot_fname<-'covid_deaths'
#plot1(plot_var,plot_fname,title,plot_countries0,plot_colors0)
plot_fname<-'covid_deaths_gsi'
plot1(plot_var,plot_fname,title,plot_countries1,plot_colors1)
plot_fname<-'covid_deaths_gcs'
plot1(plot_var,plot_fname,title,plot_countries2,plot_colors2)
plot_fname<-'covid_deaths_gbb'
plot1(plot_var,plot_fname,title,plot_countries3,plot_colors3)
plot_fname<-'covid_deaths_gar'
plot1(plot_var,plot_fname,title,plot_countries4,plot_colors4)
#################################################


#################################################
## FATALITY RATE
#################################################
title<-'fatality %'
plot_var<-'fatality_r';

#plot_fname<-'covid_fatality'
#plot1(plot_var,plot_fname,title,plot_countries0,plot_colors0)
plot_fname<-'covid_fatality_gsi'
plot1(plot_var,plot_fname,title,plot_countries1,plot_colors1)
plot_fname<-'covid_fatality_gcs'
plot1(plot_var,plot_fname,title,plot_countries2,plot_colors2)
plot_fname<-'covid_fatality_gbb'
plot1(plot_var,plot_fname,title,plot_countries3,plot_colors3,6.7)
plot_fname<-'covid_fatality_gar'
plot1(plot_var,plot_fname,title,plot_countries4,plot_colors4)
#################################################


#################################################
## CONFIRMED RATE
#################################################
title<-'Επιβεβαιωμένα κρούσματα %'
plot_var<-'confirmed_r';

#plot_fname<-'covid_confirmed'
#plot1(plot_var,plot_fname,title,plot_countries0,plot_colors0)
plot_fname<-'covid_confirmed_gsi'
plot1(plot_var,plot_fname,title,plot_countries1,plot_colors1)
plot_fname<-'covid_confirmed_gcs'
plot1(plot_var,plot_fname,title,plot_countries2,plot_colors2)
plot_fname<-'covid_confirmed_gbb'
plot1(plot_var,plot_fname,title,plot_countries3,plot_colors3)
plot_fname<-'covid_confirmed_gar'
plot1(plot_var,plot_fname,title,plot_countries4,plot_colors4)
#################################################3




main_title<-'Ελλάδα θάνατοι απο την αρχή της πανδημίας'
y_title<-'θάνατοι'
png(file='target/covid_greece_deaths.png',width=width1,height=height1)
plot(covid_greece$date, covid_greece$deaths, col='black',
     lwd=1.3, cex=1.6, cex.lab=1.6, cex.main=1.6, cex.sub=1.6, cex.axis=1.6, main=main_title,xlab='time',ylab=y_title, type="l")
grid()
dev.off()



main_title<-'Greece fatality %'
y_title<-'fatality %'
png(file='target/covid_greece_fatality.png',width=width1,height=height1)
plot(covid_greece$date, covid_greece$fatality_r, col='black',
     lwd=1.3, cex=1.6, cex.lab=1.6, cex.main=1.6, cex.sub=1.6, cex.axis=1.6, main=main_title,xlab='time',ylab=y_title, type="l")
grid()
dev.off()


main_title<-'Ελλάδα επιβεβαιωμένα κρούσματα απο την αρχή της πανδημίας'
y_title<-'confirmed'
png(file='target/covid_greece_confirmed.png',width=width1,height=height1)
plot(covid_greece$date, covid_greece$confirmed, col='black',
     lwd=1.3, cex=1.6, cex.lab=1.6, cex.main=1.6, cex.sub=1.6, cex.axis=1.6, main=main_title,xlab='time',ylab=y_title, type="l")
grid()
dev.off()


wdates <- base::as.Date(zoo::as.Date(covid_greece$w_date))

main_title<-'Ελλάδα επιβεβαιωμένα κρούσματα ανα ημέρα'
y_title<-'confirmed'
png(file='target/covid_greece_confirmed_w.png',width=width1,height=height1)
plot(wdates, covid_greece$w_confirmed, col='black',
     lwd=1.3, cex=1.6, cex.lab=1.6, cex.main=1.6, cex.sub=1.6, cex.axis=1.6, main=main_title,xlab='time',ylab=y_title, type="l")
grid()
dev.off()

main_title<-'Ελλάδα θανάτοι ανα ημέρα'
y_title<-'deaths'
png(file='target/covid_greece_deaths_w.png',width=width1,height=height1)
plot(wdates, covid_greece$w_deaths, col='black',
     lwd=1.3, cex=1.6, cex.lab=1.6, cex.main=1.6, cex.sub=1.6, cex.axis=1.6, main=main_title,xlab='time',ylab=y_title, type="l")
grid()
dev.off()


 