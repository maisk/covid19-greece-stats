
.PHONY: help fetch data clean clean_data run html init all

help:
	@echo ""
	@echo "-----------------------------------------------"
	@echo " targets:"
	@echo " all            :"
	@echo " init           :"
	@echo " fetch          :"
	@echo " data           :"
	@echo " clean_data     :"
	@echo "-----------------"
	@echo " run            :"
	@echo " clean          :"
	@echo "-----------------"
	@echo "html"

all: init fetch data run html

init:
	mkdir -p ./www/plots/
	mkdir -p ./data/covid/
	@if [ ! -L target ];then ln -s ./www/plots target; fi

fetch:
	./fetch-data.sh


data: covid_data.Rdata

covid_data.Rdata: ./data/covid/*.csv ./data/countrycode.csv
	Rscript covid_data1.R

run: clean
	Rscript covid2.R

clean: 
	@rm -f www/plots/*.png

clean_data:
	@rm -f covid_data.Rdata

html:
	#rm -f ./www/plots/*.png
	#cp target/*.png www/plots/
	php fatality.php > ./www/fatality.html
	php confirmed.php > ./www/confirmed.html
	php deaths.php > ./www/deaths.html
	php article.php > ./www/article.html


deploy:
	./deploy.sh