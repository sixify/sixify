library(gdata) 
library(ggplot2)
library(fields)
library(rjson)
library(plyr)
library(psych)


read_folder <- "C://Users//Vardan//Documents//GitHub//sixify//analyze//"

#read_file <- "D:\\github\\demo\\input_feeds\\sixify_bitstamp_btcusd.csv"

save_file_geomean <- file.path(read_folder,"..","visualize","data","sixify_geomean_btcusd")

inputPath = file.path(read_folder,"input_feeds","exchanges")

fileList = list.files(path = inputPath,pattern = ".csv$")

# 
aggrTable =  data.frame(amount=NULL,date =NULL,price = NULL)
for (i in range(1,length(fileList)))
{ 
#   
data_table <- read.table(file.path(read_folder,"input_feeds","exchanges",fileList[i]), sep=",", header=T)


aggrTable <- rbind(aggrTable, data_table)

}


# 
# 
# 
# 
# # convert timestamp
# 
# 
# 
time_bin <- 5*60 # 5 min

#new_timestamps <- seq(min(data_table$date),max(data_table$date)-time_bin,time_bin)


bin_boundaries <- seq(min(data_table$date)+time_bin,max(data_table$date)-time_bin,time_bin)


A = tapply(data_table$price, cut(data_table$date, breaks = bin_boundaries), geometric.mean)

geomean_price <- as.numeric(A[(1:length(tapply(data_table$price, cut(data_table$date, breaks = bin_boundaries), geometric.mean)))])
geomean_amount <- as.numeric(A[(1:length(tapply(data_table$price, cut(data_table$date, breaks = bin_boundaries), geometric.mean)))])


# 
binned_data_geomean <- data.frame(price = geomean_price, amount = geomean_amount, date = bin_boundaries[1:length(bin_boundaries)-1])


# save csv
# 
# write.table(binned_data_geomean, file = paste(save_file_geomean, "csv", sep = ".", collapse = NULL), append=F, row.names=F, col.names=F,  sep=",")
# 
 
# save json
 
 
 sink(paste(save_file_geomean, "txt", sep = ".", collapse = NULL))
 cat(toJSON(binned_data_geomean))
 sink()
