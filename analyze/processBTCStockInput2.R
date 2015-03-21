library(gdata) 
library(ggplot2)
library(fields)
library(rjson)
library(plyr)
library(psych)


read_folder <- "D://github//sixify//analyze//"

#read_file <- "D:\\github\\demo\\input_feeds\\sixify_bitstamp_btcusd.csv"

save_file_mean <- file.path(read_folder,"..","visualize","data","sixify_bitstamp_mean_btcusd")
save_file_sd <- file.path(read_folder,"..","visualize","data","sixify_bitstamp_sd_btcusd")
save_file_geomean <- file.path(read_folder,"..","visualize","data","sixify_bitstamp_geomean_btcusd")
#file_list <- list.files(path = read_folder, pattern = ".*.csv", all.files = FALSE, full.names = FALSE, recursive = FALSE, ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)

inputPath = file.path(read_folder,"input_feeds")

fileList = list.files(path = inputPath,pattern = ".csv$")

data_table <- read.table(file.path(read_folder,"input_feeds",fileList[3]), sep=",", header=T)

#data_table = read.table(read_file, sep=",", header=T)

# convert timestamp
time_bin <- 5*60 # 5 min

#new_timestamps <- seq(min(data_table$date),max(data_table$date)-time_bin,time_bin)
bin_boundaries <- seq(min(data_table$date)+time_bin,max(data_table$date)-time_bin,time_bin)

#as.numeric(dim(data_table)[1])

#number_of_bins <- length(new_timestamps) #(max(data_table$date) - min(data_table$date)) / time_bin

binned_price <- stats.bin(data_table$date, data_table$price,  breaks = bin_boundaries)

binned_amount <- stats.bin(data_table$date, data_table$amount,  breaks = bin_boundaries)

#binned_tid <- stats.bin(data_table$date, data_table$tid,  breaks = bin_boundaries)

# compute geometrical mean

#for (i in 1:length(bin_boundaries)-1){
  
#}
geomean_price <- as.numeric(A[(1:length(tapply(data_table$price, cut(data_table$date, breaks = bin_boundaries), geometric.mean)))])
geomean_amount <- as.numeric(A[(1:length(tapply(data_table$price, cut(data_table$date, breaks = bin_boundaries), geometric.mean)))])



binned_data_mean <- data.frame(price = binned_price$stats[ c("mean"),], amount = binned_amount$stats[ c("mean"),], date = bin_boundaries[1:length(bin_boundaries)-1])

binned_data_sd <- data.frame(price = binned_price$stats[ c("Std.Dev."),], amount = binned_amount$stats[ c("Std.Dev."),], date = bin_boundaries[1:length(bin_boundaries)-1])

binned_data_geomean <- data.frame(price = geomean_price, amount = geomean_amount, date = bin_boundaries[1:length(bin_boundaries)-1])

#binned_data_mean <- rename(binned_data_mean, c("binned_price.stats.c..mean....."="price", "binned_amount.stats.c..mean....."="amount", "binned_tid.stats.c..mean....."="tid"))
#binned_data_sd <- rename(binned_data_sd, c("binned_price.stats.c..Std.Dev......"="price", "binned_amount.stats.c..Std.Dev......"="amount", "binned_tid.stats.c..Std.Dev......"="tid"))


# save csv

write.table(binned_data_mean, file = paste(save_file_mean, "csv", sep = ".", collapse = NULL), append=F, row.names=F, col.names=F,  sep=",")
write.table(binned_data_sd, file = paste(save_file_sd, "csv", sep = ".", collapse = NULL), append=F, row.names=F, col.names=F,  sep=",")
write.table(binned_data_geomean, file = paste(save_file_geomean, "csv", sep = ".", collapse = NULL), append=F, row.names=F, col.names=F,  sep=",")

# save json

sink(paste(save_file_mean, "txt", sep = ".", collapse = NULL))
cat(toJSON(binned_data_mean))
sink()

sink(paste(save_file_sd, "txt", sep = ".", collapse = NULL))
cat(toJSON(binned_data_sd))
sink()

sink(paste(save_file_geomean, "txt", sep = ".", collapse = NULL))
cat(toJSON(binned_data_geomean))
sink()

#p <- ggplot(plot_data, aes(x = data_table$date, y = data_table$price, group = plot_data$id))
# add points and lines
#p <- p + geom_point(aes(x = plot_data$time_point, y = plot_data$intensity, colour = plot_data$particle_number), size = I(4), alpha = I(0.4)) + scale_colour_gradient(low="black", high = "magenta")
#p <- p + geom_line(aes(x = plot_data$time_point, y = plot_data$intensity, colour = plot_data$particle_number), size = I(2), alpha = I(0.4)) 
# remove background and grid
#p <- p + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank())
#p <- p + theme(axis.line = element_line(colour = "black", size = 1))
# change font size
#p <- p + theme(text = element_text(size=20, face = "bold"))
# set y axis limits and ticks
#p <- p  + scale_y_continuous(limits = c(0, 0.30), breaks= c(0.00, 0.10, 0.20, 0.30)) #  + coord_cartesian(ylim = c(0, 1))
#ggsave(file=save_file, plot=p, width=10, height=6)
#print(p);