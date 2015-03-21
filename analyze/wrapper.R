library(gdata) 
library(ggplot2)
library(fields)
library(rjson)
library(plyr)



inputPath = file.path(getwd(),"input_feeds")

fileList = list.files(path = inputPath,pattern = ".csv$")
# 
# for (currentFilePath in fileList)
# {
#   print(currentFilePath)
#   A  <- grep("sixify_(\\w*)_(\\w*).csv",currentFilePath)
#   
# 
#   
#   
#   
#   
# }
# convert timestamp

data_table <- read.table(file.path(getwd(),"input_feeds",fileList[3]), sep=",", header=T)



time_bin <- 5*60 # 5 min

new_timestamps <- seq(min(data_table$date),max(data_table$date)-time_bin,time_bin)
bin_boundaries <- seq(min(data_table$date)+time_bin,max(data_table$date)-time_bin,time_bin)

#as.numeric(dim(data_table)[1])

number_of_bins <- length(new_timestamps) #(max(data_table$date) - min(data_table$date)) / time_bin
# 
binned_price <- stats.bin(data_table$date, data_table$price,  breaks = bin_boundaries)
# 
# binned_amount <- stats.bin(data_table$date, data_table$amount,  breaks = bin_boundaries)
# 
# binned_tid <- stats.bin(data_table$date, data_table$tid,  breaks = bin_boundaries)
# 
# 
# binned_data_mean <- data.frame(binned_price$stats[ c("mean"),], binned_amount$stats[ c("mean"),], binned_tid$stats[ c("mean"),], date = new_timestamps)
# 
# binned_data_sd <- data.frame(binned_price$stats[ c("Std.Dev."),], binned_amount$stats[ c("Std.Dev."),], binned_tid$stats[ c("Std.Dev."),], date = new_timestamps)
# 
# 
# binned_data_mean <- rename(binned_data_mean, c("binned_price.stats.c..mean....."="price", "binned_amount.stats.c..mean....."="amount", "binned_tid.stats.c..mean....."="tid"))
# binned_data_sd <- rename(binned_data_sd, c("binned_price.stats.c..Std.Dev......"="price", "binned_amount.stats.c..Std.Dev......"="amount", "binned_tid.stats.c..Std.Dev......"="tid"))
# 
