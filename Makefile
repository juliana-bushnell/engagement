#! build the report
engagement_report.html: code/render_report.R
	Rscript code/render_report.R
#! create output 1 code/01_unique_views.R
output/01_unique_views.rds: code/01_unique_views.R
	Rscript code/01_unique_views.R

#! create output 2 code/02_total_views.R
output/02_total_views.rds: code/02_total_views.R
	Rscript code/02_total_views.R

#! create output 3 code/03_video_length.R
output/03_video_length.rds: code/03_video_length.R
	Rscript code/03_video_length.R


.PHONY: clean
clean: clean
	rm -f output/*.rds && rm -f output/*.png && rm -f output/*.pdf && rm -f output/*.pdf 


