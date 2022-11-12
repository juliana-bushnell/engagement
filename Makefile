#! build the report
report: code/render_report.R output_unique_views output_video_length
	Rscript code/render_report.R
#! create output 1 code/01_unique_views.R
output_unique_views: code/01_unique_views.R
	Rscript code/01_unique_views.R

#! create output 2 code/02_total_views.R
output_total_views: code/02_total_views.R
	Rscript code/02_total_views.R

#! create output 3 code/03_video_length.R
output_video_length: code/03_video_length.R
	Rscript code/03_video_length.R

.PHONY: clean
clean: clean
	rm -f output/*.*
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"



