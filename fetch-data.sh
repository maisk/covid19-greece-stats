#!/bin/bash
RCOVID_HOME=$(pwd)
RCOVID_DATA_HOME=${RCOVID_HOME}/data/covid
BASE_URL="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/"


date -u  "+%Y-%m-%d %H:%M:%S%z"  > "${RCOVID_DATA_HOME}/fetch.log"


function fetch {
	curl "${BASE_URL}${1}" >  "${RCOVID_DATA_HOME}/${1}"
}


fetch "time_series_covid19_confirmed_global.csv"
fetch "time_series_covid19_deaths_global.csv"
fetch "time_series_covid19_recovered_global.csv"
