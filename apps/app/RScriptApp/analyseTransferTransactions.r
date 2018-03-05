library(jsonlite)
library(tibble)
library(dplyr)
library(ggplot2)

#------------------
# get extracted data transferTransactions.json
#-----------------
transferTransactions_json <- fromJSON("/host/transferTransactions.json")
#str(transferTransactions_json)

#------------------
# clean data
#-----------------
transferTransactionsJson_flat <- flatten(transferTransactions_json)
#str(transferTransactionsJson_flat)
transferTransactions_tbl <- as_data_frame(transferTransactionsJson_flat)
#transferTransactions_tbl

#--------------------------------------------------------
# create plot points
#--------------------------------------------------------
p <- ggplot(data=transferTransactions_tbl, aes(x=blockNumber,y=value))
p <-p + geom_point(alpha = 1/20)
p <- p + ggtitle("ERC20 Transfer value") + xlab("blockNumber") + ylab("Transfer value")
ggsave(plot=p, file="/host/transferTransactionsAnalyse.png")
