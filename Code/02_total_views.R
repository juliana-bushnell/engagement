library(dplyr)
library(here)

here::i_am("code/02_total_views.R")

configlist<-config::get()

# load data
data <- read.csv(here::here("course_engagement.csv"), header=TRUE)

# recode error in week 1 video_number
data <- data %>%
  group_by(week) %>%
  mutate(video_number = 1:length(video_number)) %>%
  ungroup()

# include only week, video_number, and views columns
data <- data[, c(1,2,5)]

# create table
data1 <- data %>% 
  pivot_wider(names_from = video_number,
              values_from = views, names_prefix = "video")

configlist$parameter<-data1%>%slice(configlist$numberparam)

saveRDS(
  configlist$parameter,
  file = here::here(paste0("output/week",configlist$numberparam,"_total_views_table.rds")
  ))

# create visualization
data3 <- data %>% filter(week == configlist$numberparam)

barplot <- ggplot(data3, aes(x=video_number, y=views)) +
  geom_bar(stat = "identity") + ggtitle("Views for each video in week **") +
  xlab("Video number") + ylab("Views")

ggsave(
  here::here(paste0("output/week",configlist$numberparam,"_total_views_barplot.png")),
  plot=barplot,
  device = "png"
)
