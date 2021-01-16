
.PHONY: help fetch data clean clean_data run html

help:
	@echo ""
	@echo "-----------------------------------------------"
	@echo " targets:"
	@echo " fetch          :"
	@echo " data           :"
	@echo " clean_data     :"
	@echo "-----------------"
	@echo " run            :"
	@echo " clean          :"
	@echo "-----------------"
	@echo "html"


fetch:
	./fetch-data.sh


data: covid_data.Rdata

covid_data.Rdata: ./data/covid/*.csv ./data/countrycode.csv
	Rscript covid_data1.R

run: clean
	Rscript covid2.R

clean: 
	@rm -f *.png

clean_data:
	@rm -f covid_data.Rdata

html: *.png
	rm -f ./www/plots/*.png
	cp *.png www/plots/

deploy:
	./deploy.sh