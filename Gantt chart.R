library(knitr)
library(tidyverse)
library(RColorBrewer)
library(tidyverse)
library(readxl)
library(reshape2)
library(ggplot2)
rm(list = ls())

dbq<-read_excel("/Users/kumerengovender/Desktop/Academic_work_2019/Transfer to DPhil Status/Document/Gantt_chart.xlsx",sheet="Sheet1") 
print(dbq)

df=dbq %>% map_df(rev)
names(df) <- c('task', 'start', 'end')
df$task <- factor(df$task, levels = df$task) 
df$start <- as.Date(df$start)
df$end <- as.Date(df$end)
df_melted <- melt(df, measure.vars = c('start', 'end'))

##To bold lines on the x-axis
bold=rep("plain",20)
bold[4]="bold"
bold[7]="bold"
bold[14]="bold"
bold[17]="bold"

##To change the color of individual bars
coll=rep("blue",40)
coll[27]="dark blue"
coll[33]="dark blue"
coll[13]="dark blue"
coll[7]="dark blue"


## Starting date to begin plot
start_date <- as.Date('2018-09-01')

ggplot(df_melted, aes(value, task)) + 
  geom_line(size = 3, colour=coll) +
  labs(x = '', y = '') +
  theme_bw(base_size = 10) +
  theme(plot.title = element_text(hjust = 0.5),panel.grid.major.y = element_line(colour="grey96", linetype = "solid"),
        panel.grid.major.x = element_line(colour="grey96", linetype = "solid"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(angle = 90), axis.text.y = element_text(face = bold)) +
  scale_x_date(date_labels = "%Y %b", limits = c(start_date, NA), date_breaks = '1 month')

##Change date_breaks to alter the scale of the y-axis(timeline)

