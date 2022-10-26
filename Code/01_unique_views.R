library(here)
library(dplyr)
library(tidyverse)
library(gtsummary)
library(ggplot2)
here::i_am("code/01_unique_views.R")
configlist<-config::get()
absolute_file_path<-here::here("course_engagement.csv")
data <- read.csv(absolute_file_path, header = TRUE)
#Table
data <- data %>%
  group_by(week) %>%
  mutate(video_number = 1:length(video_number)) %>%
  ungroup()

data <- data[, -c(3,4,5,7,8)]

data1 <-data%>%
  pivot_wider(names_from = video_number, 
              values_from = unique_viewers,names_prefix = "video")

configlist$parameter<-data1%>%slice(configlist$numberparam)
saveRDS(
  configlist$parameter,
  file = here::here(paste0("output/week",configlist$numberparam,"_Unique_views_table.rds")
))

#Visualization
data<-data%>%filter(week==configlist$numberparam)
barplot<-ggplot(data, aes(x=video_number, y=unique_viewers)) + 
  geom_bar(stat = "identity")
ggsave(
  here::here(paste0("output/week",configlist$numberparam,"_Unique_views_barplot.png")),
  plot=barplot,
  device = "png"
)