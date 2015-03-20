library(gdata) 
library(ggplot2)
library(fields)
library(rjson)


read_file <- "D:\\github\\demo\\input_feeds\\sixify_bitstamp_btcusd.csv"

save_file_mean <- "D:\\github\\sixify\\visualize\\sixify_mean_btcusd"
save_file_sd <- "D:\\github\\sixify\\visualize\\sixify_sd_btcusd_sd"

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