# Engagement Project

## Restoring the package environment

run

```{bash}
make install
```

## Select week of interest

run

```{bash}
export WEEK=6
```

## Generate Report

run

```{bash}
make report.html
```

## Delete Report and Report files

run

```{bash}
make clean
```

## Project Description

Our project will be stored in one main folder that contains a code folder and output folder. In the main project folder, there will also be a render.R file, an RMD file with the combined report, and a make file. In the Code folder, there will be a .R file for each of the coder’s parts. In the output folder, there will be the outputs for each of the parts. See below for visual structure. 
## Project folder
Folder: CODE
  01_unique_views.R
  02_total_views.R
  03_video_length.R
Folder: OUTPUT
  Output for each coder’s part (.png, .rds etc)
Render_report.R
Combined_report.Rmd
Makefile
ReadMe
 
## Customization
Finally, we will customize the report using a config file. The user will select which week they want to produce in the tables and graphs of our combined_report. Each part of the output will be customized with whatever week the user would like to view.  
