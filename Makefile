RUN=Rscript --vanilla

# final output
all: upload/plot/dls.png

# db.R + [www] -> survey.csv
db/survey.csv: db.R
	$(RUN) db.R

# input.R + survey.csv -> input.RData
input/input.RData: db/survey.csv
	$(RUN) input.R

# model.R + input.RData -> dls.txt
model/dls.txt: input/input.RData
	$(RUN) model.R

# output.R + dls.txt -> dls.txt
output/dls.txt: model/dls.txt
	$(RUN) output.R

# upload.R + dls.txt -> dls.txt
upload/output/dls.txt: output/dls.txt
	$(RUN) upload.R

# xtra_plot.R + dls.txt -> dls.png
upload/plot/dls.png: upload/output/dls.txt
	$(RUN) xtra_plot.R

clean:
	$(RUN) -e "icesTAF::clean()"
