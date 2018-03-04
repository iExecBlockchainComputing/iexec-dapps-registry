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

#------------------------
# analyse data : group_by transfer value
#------------------------
transferTransactionsAnalyseData <- transferTransactions_tbl %>% group_by(value) %>%
summarise(
   n = n()
 ) %>%
arrange(desc(value))
#transferTransactionsAnalyseData

#---------------------------------------------------------------
# write analyse result in a file transferTransactionsAnalyse.csv
#---------------------------------------------------------------
write.csv2(transferTransactionsAnalyseData,file = "/host/transferTransactionsAnalyse.csv")

#--------------------------------------------------------
# create histogram image transferTransactionsAnalyse.png
#--------------------------------------------------------
p <- ggplot(data=transferTransactionsAnalyseData, aes(x=value,y=n, fill=n))
p <- p + geom_histogram(stat = "identity")
p <- p + ggtitle("ERC20 value transfer") + xlab("value transfer") + ylab("count")
ggsave(plot=p, file="/host/transferTransactionsAnalyse.png")
