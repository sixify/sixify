library(gdata) 
library(ggplot2)
library(fields)
library(rjson)


read_file <- "C:\\Users\\Vardan\\Documents\\GitHub\\sixify\\analyze\\input_feeds\\sixify_bitstamp_btcusd.csv"

save_file_mean <- "..\\visualize\\sixify_mean_btcusd"
save_file_sd <- "..\\visualize\\sixify_sd_btcusd"

data_table = read.table(read_file, sep=",", header=T)

# convert timestamp
time_bin <- 5*60 # 5 min

#as.numeric(dim(data_table)[1])

number_of_bins <-  (max(data_table$date) - min(data_table$date)) / time_bin

binned_price <- stats.bin(data_table$date, data_table$price, N = number_of_bins, breaks = NULL)

binned_amount <- stats.bin(data_table$date, data_table$amount, N = number_of_bins, breaks = NULL)

binned_tid <- stats.bin(data_table$date, data_table$tid, N = number_of_bins, breaks = NULL)


binned_data_mean <- data.frame(binned_price$stats[ c("mean"),], binned_amount$stats[ c("mean"),], binned_tid$stats[ c("mean"),])

binned_data_sd <- data.frame(binned_price$stats[ c("Std.Dev."),], binned_amount$stats[ c("Std.Dev."),], binned_tid$stats[ c("Std.Dev."),])

# save csv

write.table(binned_data_mean, file = paste(save_file_mean, "csv", sep = ".", collapse = NULL), append=F, row.names=F, col.names=F,  sep=",")
write.table(binned_data_sd, file = paste(save_file_sd, "csv", sep = ".", collapse = NULL), append=F, row.names=F, col.names=F,  sep=",")


# save json

sink(paste(save_file_mean, "txt", sep = ".", collapse = NULL))
cat(toJSON(binned_data_mean))
sink()

sink(paste(save_file_sd, "txt", sep = ".", collapse = NULL))
cat(toJSON(binned_data_sd))
sink()
