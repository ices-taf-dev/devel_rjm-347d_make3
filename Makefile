RUN=Rscript --vanilla

# Script     Output
# ------     ------
# db         survey.csv
# input      input.RData
# model      dls.txt
# output     dls.txt
# upload     dls.txt
# xtra_plot  dls.png

all: upload/plot/dls.png

db/survey.csv: db.R
	$(RUN) db.R

input/input.RData: db/survey.csv
	$(RUN) input.R

model/dls.txt: input/input.RData
	$(RUN) model.R

output/dls.txt: model/dls.txt
	$(RUN) output.R

upload/output/dls.txt: output/dls.txt
	$(RUN) upload.R

upload/plot/dls.png: upload/output/dls.txt
	$(RUN) xtra_plot.R

clean:
	$(RUN) -e "icesTAF::clean()"
