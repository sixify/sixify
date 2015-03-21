library(gdata) 
library(ggplot2)
library(fields)
library(rjson)
library(plyr)
library(psych)


read_folder <- "C://Users//Vardan//Documents//GitHub//sixify//analyze//"

#read_file <- "D:\\github\\demo\\input_feeds\\sixify_bitstamp_btcusd.csv"

save_file_geomean <- file.path(read_folder,"..","visualize","data","sixify_aggregate_btcusd")#bitstamp btce cexio

inputPath = file.path(read_folder,"input_feeds","exchanges")

fileList = list.files(path = inputPath,pattern = ".csv$")

# 
# # aggrTable =  data.frame(amount=NULL)
# for (i in range(1,4))
# { 
#   
data_table1 = read.table(file.path(read_folder,"input_feeds","exchanges",fileList[1]), sep=",", header=T)
data_table2 = read.table(file.path(read_folder,"input_feeds","exchanges",fileList[2]), sep=",", header=T)
data_table3 = read.table(file.path(read_folder,"input_feeds","exchanges",fileList[3]), sep=",", header=T)
data_table4 = read.table(file.path(read_folder,"input_feeds","exchanges",fileList[4]), sep=",", header=T)


aggrTable = merge(merge(merge(data_table1,data_table2,all = TRUE), data_table3,all = TRUE),data_table4, all = TRUE) 
calcTable = aggrTable

save_file_geomean <- file.path(read_folder,"..","visualize","data","sixify_aggregation_btcusd")
#   
# 
# 
# 
# 
# 
# 
# # convert timestamp
# 
# 
# 
time_bin <- 1*60 # 5 min

#new_timestamps <- seq(min(data_table$date),max(data_table$date)-time_bin,time_bin)


bin_boundaries <- seq(min(calcTable$date)+time_bin,max(calcTable$date)-time_bin,time_bin)


geomean_price = tapply(calcTable$price, cut(calcTable$date, breaks = bin_boundaries), geometric.mean)
geomean_amount = tapply(calcTable$amount, cut(calcTable$date, breaks = bin_boundaries), geometric.mean)
# geomean_price <- as.numeric(A[(1:length(tapply(calcTable$price, cut(calcTable$date, breaks = bin_boundaries), geometric.mean)))])
# geomean_amount <- as.numeric(A[(1:length(tapply(calcTable$price, cut(calcTable$date, breaks = bin_boundaries), geometric.mean)))])


# 
binned_data_geomean <- data.frame(price = geomean_price, amount = geomean_amount, date = bin_boundaries[1:length(bin_boundaries)-1])

binned_data_geomean = format(na.omit(binned_data_geomean),scientific=FALSE)

# save csv

# write.table(binned_data_geomean, file = paste(save_file_geomean, "csv", sep = ".", collapse = NULL), append=F, row.names=F, col.names=F,  sep=",")
write.table(format(binned_data_geomean, scientific=FALSE), file = paste(save_file_geomean, "csv", sep = ".", collapse = NULL), append=F, row.names=F, col.names=F,  sep=",")
 
# save json

#  
 sink(paste(save_file_geomean, "txt", sep = ".", collapse = NULL))
 cat(toJSON(binned_data_geomean))
 sink()

