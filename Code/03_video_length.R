library(here)
library(dplyr)
library(tidyverse)
library(gtsummary)
library(ggplot2)
library(lubridate)

here::i_am("code/03_video_length.R")

#configlist<-config::get()
week_select <- as.numeric(Sys.getenv("WEEK"))

absolute_file_path<-here::here("course_engagement.csv")

data <- read.csv(absolute_file_path, header = TRUE)

data$lengthinseconds <- period_to_seconds(ms(data$length))

NA_length_rows <- which(is.na(data$lengthinseconds))
data$lengthinseconds[NA_length_rows] <- period_to_seconds(hms(data$length[NA_length_rows]))

#Table
data <- data %>%
  group_by(week) %>%
  mutate(video_number = 1:length(video_number)) %>%
  ungroup()

data <- data %>% select(week, video_number, lengthinseconds)

data1 <-data%>%
  pivot_wider(names_from = video_number, 
              values_from = lengthinseconds,names_prefix = "video")

dat_for_table <- data1 %>% slice(week = week_select)

saveRDS(
  dat_for_table,
  file = here::here(paste0("output/week",week_select,"_video_length_table.rds")
  ))

#Visualization

data <- data %>% filter(week == week_select)

barplot<-ggplot(data, aes(x=video_number, y=lengthinseconds)) + 
  geom_bar(stat = "identity") +
  labs(x="Video Number",y="video length in seconds")

#barplot

ggsave(
  here::here(paste0("output/week",week_select,"_video_length_plot.png")),
  plot=barplot,
  device = "png"
)
