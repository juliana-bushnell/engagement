library(here)
library(dplyr)
library(tidyverse)
library(gtsummary)
library(ggplot2)
library(lubridate)
here::i_am("code/03_video_length.R")
configlist<-config::get()
absolute_file_path<-here::here("course_engagement.csv")
data <- read.csv(absolute_file_path, header = TRUE)
data$lengthinseconds <- period_to_seconds(ms(data$length))
data$lengthinseconds[4] <- period_to_seconds(hms(data$length[4]))

#Table
data <- data %>%
  group_by(week) %>%
  mutate(video_number = 1:length(video_number)) %>%
  ungroup()

data <- data[, -c(3,4,5,6,7,8)]

data1 <-data%>%
  pivot_wider(names_from = video_number, 
              values_from = lengthinseconds,names_prefix = "video")

configlist$parameter <- data1%>%slice(configlist$numberparam)

saveRDS(
  configlist$parameter,
  file = here::here(paste0("output/week",configlist$numberparam,"_video_length_table.rds")
  ))

#Visualization

data <- data%>%filter(week==configlist$numberparam)

barplot<-ggplot(data, aes(x=video_number, y=lengthinseconds)) + 
  geom_bar(stat = "identity") +
  labs(x="Video Number",y="video length in seconds")

#barplot

ggsave(
  here::here(paste0("output/week",configlist$numberparam,"_video_length_plot.png")),
  plot=barplot,
  device = "png"
)
